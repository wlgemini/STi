//
//  Color.swift
//

import UIKit


/// Color
public struct Color {
    
    /// 8-bit color
    ///
    /// - Parameters:
    ///   - r: 0~255
    ///   - g: 0~255
    ///   - b: 0~255
    ///   - a: 0~255
    public static func rgba255(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red255: r, green255: g, blue255: b, alpha255: a)
    }
    
    /// Hex color
    ///
    /// - Parameter rgba: Hex value
    ///
    /// eg:
    /// ```
    /// 0xFF0000FF  // red
    /// 0x00FF00FF  // green
    /// 0x0000FFFF  // blue
    /// ```
    ///
    public static func rgbaHex(_ rgba: Int64) -> UIColor {
        return UIColor(hexRGBA: rgba)
    }
    
    /// Random color
    public static func random() -> UIColor {
        return Color.rgba255(CGFloat.random(in: 0...255), CGFloat.random(in: 0...255), CGFloat.random(in: 0...255), 255)
    }
}
