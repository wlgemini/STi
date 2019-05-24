//
//  Network.swift
//

import Alamofire


/// Network
public struct Network {
    
    /// Base URL
    public static var baseURL: () -> String = { return "" }
    
    /// All Http headers
    public static var HTTPHeaders: [String: () -> String] = [:]
    
    /// timeout
    public static var timeoutIntervalForRequest: TimeInterval = 15
    
    /// network error handler: [ErrorCode: Handler]
    public static var networkErrorHandler: (Error) -> Void = { _ in }
    
    // MARK: - Private
    /// SessionManager
    private static let _sesstion: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = Network.timeoutIntervalForRequest
        return SessionManager(configuration: config)
    }()
    
    /// Init
    private init() {}
}


extension Network {
    
    /// req
    public static func req<DS: DataStructure>(_ req: Request<DS>, param: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping (Alamofire.Result<DS.Value>) -> Void) -> Alamofire.DataRequest {
        // url (debug/mock/release)
        var url = self.baseURL() + req.relativeURL
        assert({ url = req.mockingToURL ?? url; return true }())
        
        // req
        let headers = self.HTTPHeaders.mapValues { $0() }
        return self._sesstion.request(url, method: req.HTTPMethod, parameters: param, encoding: encoding, headers: headers)
            .validate()
            .response(responseSerializer: _DataResponseDecoder<DS>()) { (response) in
                switch response.result {
                case .success(let serverStructure):
                    let result = serverStructure.flatMap()
                    completion(result)
                    
                case .failure(let error):
                    self.networkErrorHandler(error)
                    completion(.failure(error))
                }
        }
    }
}

extension Network {
    
    /// _DataResponseDecoder
    private struct _DataResponseDecoder<Model: Decodable>: DataResponseSerializerProtocol {
        
        var serializeResponse = { (request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Alamofire.Result<Model> in
            // Alamofire的基础校验: 校验error, statusCode, data是否存在, 并不查看data的具体内容
            let result = Alamofire.Request.serializeResponseData(response: response, data: data, error: error)
            
            // 解析data
            switch result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    return .success(object)
                }
                catch {
                    return .failure(error)
                }
                
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}


