//
//  EdgeInsetsLabel.swift
//

import UIKit


open class EdgeInsetsLabel: UILabel {
    
    /// text edge-insets
    public var textEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fitSize = super.sizeThatFits(CGSize(width: size.width - self.textEdgeInsets.left - self.textEdgeInsets.right, height: CGFloat(Int.max)))
        fitSize.width += self.textEdgeInsets.left + self.textEdgeInsets.right
        fitSize.height += self.textEdgeInsets.top + self.textEdgeInsets.bottom
        return fitSize
    }
    
    open override func drawText(in rect: CGRect) {
        let rect = CGRect(x: self.textEdgeInsets.left,
                          y: self.textEdgeInsets.top,
                          width: rect.width - self.textEdgeInsets.left - self.textEdgeInsets.right,
                          height: rect.height - self.textEdgeInsets.top - self.textEdgeInsets.bottom)
        super.drawText(in: rect)
    }
}
