//
//  Request.swift
//

import Alamofire


public struct Request<S: DataStructure> {
    
    /// HTTPMethod
    public let HTTPMethod: Alamofire.HTTPMethod
    
    /// relativeURL
    public var relativeURL: String
    
    /// mockingToURL
    public var mockingToURL: String?
    
    /// Init
    public init(_ HTTPMethod: Alamofire.HTTPMethod, _ relativeURL: String) {
        self.HTTPMethod = HTTPMethod
        self.relativeURL = relativeURL
    }
}
