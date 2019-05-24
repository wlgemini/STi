//
//  UIColor+.swift
//

import UIKit


extension UIColor {

    // MARK: Property
    public class var random: UIColor {
        let r = CGFloat(arc4random_uniform(255))
        let g = CGFloat(arc4random_uniform(255))
        let b = CGFloat(arc4random_uniform(255))
        return UIColor(red255: r, green255: g, blue255: b, alpha255: 255.0)
    }
    
    // MARK: - Func
    
    /// 255 Color
    ///
    /// - Parameters:
    ///   - r: 0~255
    ///   - g: 0~255
    ///   - b: 0~255
    ///   - a: 0~255
    public convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha255: CGFloat) {
        self.init(red: red255/255.0, green: green255/255.0, blue: blue255/255.0, alpha: alpha255/255.0)
    }
    
    /// Hex Color
    ///
    /// - Parameter hexRGBA: eg: 0x00FF00FF
    public convenience init(hexRGBA: Int64) {
        let r = CGFloat((hexRGBA & 0xFF000000) >> 24)
        let g = CGFloat((hexRGBA & 0x00FF0000) >> 16)
        let b = CGFloat((hexRGBA & 0x0000FF00) >> 8)
        let a = CGFloat((hexRGBA & 0x000000FF) >> 0)
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
    }
}
