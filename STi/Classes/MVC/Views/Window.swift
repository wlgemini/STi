//
//  Window.swift
//

import UIKit


class Window: UIWindow {
    
    // MARK: - Public
    /// window一些事件的代理，之所以叫windowDelegate是因为window有一个私有的delegate属性，重名了
    weak var windowDelegate: WindowDelegate?
    
    /// 是否被别的window覆盖了
    var isCovered: Bool {
        let keys = Window._map.keys
        for key in keys {
            if key > self.windowLevel { return true }
        }
        return false
    }
    
    
    /// create window
    static func createWindow(for level: UIWindow.Level) -> Window {
        var targetWin = self._map[level]
        
        if targetWin == nil {
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, willCreateWindowForLevel: level)
                }
            }
            
            // target window
            targetWin = Window()
            targetWin?.frame = UIScreen.main.bounds
            
            // 不同iOS版本window.backgroundColor不一样，有的是nil, 有的是black。当它是block时，就会导致该window一片黑，遮挡mainWindow。
            targetWin?.backgroundColor = nil
            targetWin?.windowLevel = level
            targetWin?.isHidden = false
            self._map[level] = targetWin
            
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, didCreateWindowForLevel: level)
                }
            }
        }
        
        return targetWin!
    }
    
    /// get window
    static func getWindow(for level: UIWindow.Level) -> Window? {
        return self._map[level]
    }
    
    /// remove window
    @discardableResult
    static func removeWindow(for level: UIWindow.Level) -> Window? {
        if let targetWin = self._map[level] {
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, willRemoveWindowForLevel: level)
                }
            }
            
            // remove window
            // 当window.hidden = YES时才能被释放，移除对window的唯一引用，window就释放了
            targetWin.isHidden = true
            self._map.removeValue(forKey: level)
            
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, didRemoveWindowForLevel: level)
                }
            }
            return targetWin
            
        } else {
            return nil
        }
    }
    
    static func makeKeyAndVisibleWindow(for level: UIWindow.Level, visible: Bool) {
        if let targetWin = self._map[level] {
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, willMakeKeyAndVisibleWindow: level)
                }
            }
            
            // Key And Visible
            if visible {
                targetWin.makeKeyAndVisible()
            } else {
                targetWin.makeKey()
            }
            
            // 通知delegate们(不含targetWin)
            self._map.values.forEach { (win) in
                if targetWin != win {
                    win.windowDelegate?.window(window: win, didMakeKeyAndVisibleWindow: level)
                }
            }
        }
    }
    
    // MARK: - Private
    private static var _map: [UIWindow.Level: Window] = [:]
}


protocol WindowDelegate: class {
    func window(window: Window, willCreateWindowForLevel level: UIWindow.Level)
    func window(window: Window, didCreateWindowForLevel level: UIWindow.Level)
    
    func window(window: Window, willRemoveWindowForLevel level: UIWindow.Level)
    func window(window: Window, didRemoveWindowForLevel level: UIWindow.Level)
    
    func window(window: Window, willMakeKeyAndVisibleWindow level: UIWindow.Level)
    func window(window: Window, didMakeKeyAndVisibleWindow level: UIWindow.Level)
}

extension WindowDelegate {
    func window(window: Window, willCreateWindowForLevel level: UIWindow.Level) {}
    func window(window: Window, didCreateWindowForLevel level: UIWindow.Level) {}
    
    func window(window: Window, willRemoveWindowForLevel level: UIWindow.Level) {}
    func window(window: Window, didRemoveWindowForLevel level: UIWindow.Level) {}
    
    func window(window: Window, willMakeKeyAndVisibleWindow level: UIWindow.Level) {}
    func window(window: Window, didMakeKeyAndVisibleWindow level: UIWindow.Level) {}
}

