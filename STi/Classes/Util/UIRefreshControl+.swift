//
//  UIRefreshControl+.swift
//

import UIKit


extension UIRefreshControl {
    
    /// 手动调用刷新
    public func beginRefreshingProgramatically() {
        guard self.isRefreshing == false else { return }
        
        DispatchQueue.main.async {
            if let scrollView = self.superview as? UIScrollView {
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - self.frame.height), animated: true)
            }
            self.beginRefreshing()
        }
    }
}
