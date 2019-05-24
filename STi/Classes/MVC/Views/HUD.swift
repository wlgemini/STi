//
//  HUD.swift
//

import PKHUD


public struct HUD {
    
    /// Show an auto-hidden message
    public static func message(_ msg: String, onView: UIView? = nil, width: CGFloat = 250.0, completion: ((Bool) -> Void)? = nil) {
        // let msg = String(msg.prefix(100))
        var delay: TimeInterval = TimeInterval(msg.count) * 0.10
        delay = delay > 10 ? 10 : delay
        guard delay > 0 else { return }
        
        let lb = EdgeInsetsLabel()
        lb.text = msg
        lb.frame.size = lb.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
        PKHUD.sharedHUD.contentView = lb
        PKHUD.sharedHUD.show(onView: onView)
        PKHUD.sharedHUD.hide(afterDelay: delay, completion: completion)
    }
    
    /// Show Activity
    public static func activity(onView: UIView? = nil) {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show(onView: onView)
    }
    
    /// hide
    public static func hide(animated anim: Bool = true) {
        PKHUD.sharedHUD.hide(anim)
    }
    
    /// hide after
    public static func hide(afterDelay delay: TimeInterval, completion: @escaping () -> Void = {}) {
        PKHUD.sharedHUD.hide(afterDelay: delay) { (_) in
            completion()
        }
    }
}
