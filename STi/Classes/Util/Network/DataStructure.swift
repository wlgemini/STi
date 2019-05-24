//
//  DataStructure.swift
//

import Alamofire


public protocol DataStructure: Decodable {
    
    /// the content in structured-data from server
    associatedtype Value: Decodable
    
    /// return an new "Result", which contain "Value" as ".success" case or else.
    func flatMap() -> Alamofire.Result<Value>
}
