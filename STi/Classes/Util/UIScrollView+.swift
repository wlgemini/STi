//
//  UIScrollView+.swift
//

import UIKit


extension UIScrollView {
    
    /// 滚动到底部
    public func scrollsToBottom(animated: Bool) {
        let bot = max(self.contentSize.height - self.bounds.height + self.contentInset.bottom, 0)
        self.setContentOffset(CGPoint(x: 0, y: bot), animated: animated)
    }
    
}
