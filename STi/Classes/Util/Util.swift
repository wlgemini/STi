//
//  Util.swift
//

import Foundation


public struct Util {
    
    /// execute only in debug
    public static func debugOnly(_ execute: () -> Void) {
        assert({ execute(); return true }())
    }
    
    /// print only in debug
    public static func log(_ items: @autoclosure () -> Any, file: String = #file, line: Int = #line) {
        assert({ print("@\((file as NSString).lastPathComponent)#\(line)> \(items())"); return true }())
    }
    
    /// Async in main-queue
    public static func asyncInMain(execute work: @escaping () -> Void) {
        DispatchQueue.main.async(execute: work)
    }
    
    /// Async in main-queue after
    public static func asyncInMainAfter(_ after: TimeInterval, execute work: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: work)
    }
    
    /// Async in global-queue
    public static func asyncInGlobal(execute work: @escaping () -> Void) {
        DispatchQueue.global().async(execute: work)
    }
    
}
