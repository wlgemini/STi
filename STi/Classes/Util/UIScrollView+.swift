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


extension UIScrollView {
    
    /// preloader
    public var preloader: Preloader {
        if let pld = self._preloader {
            return pld
        } else {
            let pld = Preloader(base: self)
            self._preloader = pld
            return pld
        }
    }
    
    private var _preloader: Preloader? {
        get { return objc_getAssociatedObject(self, &UIScrollView._preloaderKey) as? Preloader }
        set { objc_setAssociatedObject(self, &UIScrollView._preloaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    @objc func _swizzleContent(_ offset: CGPoint) {
        self._preloader?._observeContentOffset(offset)
        self._swizzleContent(offset)
    }
    
    /// Preloader Key
    private static var _preloaderKey: Void?
}

open class Preloader: NSObject {
    // MARK: - Public
    /// Base view
    public private(set) weak var base: UIScrollView?
    
    /// 预加载的阈值, 范围0~1. (默认0, 即底部未展示部分占整个UIScrollView高度的0.3时，触发预加载)
    public var threshold: CGFloat = 0.3
    
    /// 预加载结束时，设置为false, 激活预加载时，会自动设为true
    public var isLoading: Bool = false
    
    /// 就像UIButton一样, 设置为false整个预加载就失效了, 默认为true
    public var isEnabled: Bool = true
    
    /// 添加target
    public func addTarget(_ target: NSObject, action: Selector) {
        self._target = target
        self._action = action
    }
    
    // MARK: - Private
    // MARK: Prop
    /// target
    private weak var _target: NSObject?
    private var _action: Selector?
    private static let _swizzle: Void = {
        let cls = UIScrollView.self
        // 创建消息对象
        let originalSelector = #selector(setter: UIScrollView.contentOffset)
        let swizzleSelector = #selector(UIScrollView._swizzleContent)
        // 创建方法
        let ori_method = class_getInstanceMethod(cls, originalSelector)
        let swi_method = class_getInstanceMethod(cls, swizzleSelector)
        // 交换两个方法的实现部分
        method_exchangeImplementations(ori_method!,swi_method!)
    }()
    
    // MARK: Func
    /// Init
    fileprivate convenience init(base: UIScrollView) {
        _ = Preloader._swizzle
        self.init()
        self.base = base
    }
    
    /// observe contentOffset
    fileprivate func _observeContentOffset(_ offset: CGPoint) {
        // 1. 判断
        guard let base = self.base else { return }
        if self.isEnabled == false { return }
        if self.isLoading { return }
        // 不是用户拖动,就直接返回
        if base.isDragging == false { return }
        
        // 2. 计算
        let scvH = base.bounds.size.height
        let conSizeH = base.contentSize.height - base.contentInset.top - base.contentInset.bottom
        let conOffsetY = offset.y   // base.contentOffset.y
        if conOffsetY <= 0 { return } // 向下拉的忽略
        let remainConSizeH = conSizeH - conOffsetY
        let thresholdH = scvH + scvH * self.threshold
        if remainConSizeH <= thresholdH {
            self.isLoading = true
            _ = self._target?.perform(self._action, with: self)
        }
    }
}
