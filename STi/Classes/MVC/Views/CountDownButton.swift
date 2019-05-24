//
//  CountDownButton.swift
//

import UIKit


open class CountDownButton: UIButton {
    // MARK: - Def
    public typealias ActionBlock = (_ btn: CountDownButton) -> Void
    
    // MARK: - Public
    /// 倒计时总时长, 为0时调用startCountDown，会直接触发结束回调
    public private(set) var totalSec: TimeInterval = 0
    
    /// 剩余时间, 小于等于0，表示没有剩余时间
    public var remainSec: TimeInterval { return self._starSec + self.totalSec - self._currSec }
    
    /// 触发倒计时的时间间隔
    public private(set) var timeInterval: TimeInterval = 1
    
    /// 用于全局倒计时的ID, 为空表示不使用全局倒计时
    public private(set) var identifier: String?
    
    /// 调用startCountDown时触发该回调
    public var onStartCountDown: ActionBlock?
    
    /// 倒计时开始后, 每timeInterval间隔调用一次
    public var onCountDown: ActionBlock?
    
    /// 倒计时完成 或 调用stopCountDown时，触发该回调
    public var onStopCountDown: ActionBlock?
    
    // MARK: Func
    /// 开始倒计时，并屏当前按钮蔽触摸事件，连续多次调用该方法只会触发一次onStartCountDown
    ///
    /// - Parameters:
    ///   - totalSec: 倒计时总时长
    ///   - timeInterval: 触发倒计时的时间间隔
    ///   - identifier: 用于全局倒计时的ID, 为空表示不使用全局倒计时
    public func startCountDown(withTotalSecond totalSec: TimeInterval, timeInterval: TimeInterval = 1, identifier: String? = nil) {
        
        // 1.1 检查：输入参数是否正常
        guard totalSec > 0, timeInterval > 0 else { return }
        
        // 1.2 检查：上次的倒计时任务需已经结束
        guard self.remainSec <= 0 else { return }
        
        // 2. 存储这次倒计时任务的参数
        self.totalSec = totalSec
        self.timeInterval = timeInterval
        self.identifier = identifier
        
        // 3. 查看这次倒计时任务的剩余时间
        let remainSec = self.remainSec
        
        // 4. 若没有剩余时间, 开启新的倒计时, 记录新的开启计时时间
        if remainSec <= 0 {
            self._starSec = self._currSec
        }
        
        // 5. 开始倒计时
        self._startTimer()
    }
    
    /// 停止倒计时
    public func stopCountDown() {
        // 1.1 重置开始时间(这步必须在‘重置参数之前’, 因为这是个‘计算属性’, 依赖于其他参数)
        self._starSec = 0
        // 1.2 重置参数
        self.totalSec = 0
        self.timeInterval = 1
        self.identifier = nil
        
        // 2. 停止倒计时
        self._stopTimer()
    }
    
    // MARK: - Private
    // MARK: Prop
    private static var _timestampMap: [String: TimeInterval] = [:]
    private weak var _timer: Timer?
    private var _locStarSec: CFTimeInterval = 0
    private var _starSec: CFTimeInterval {
        get {
            if let id = self.identifier {
                return CountDownButton._timestampMap[id] ?? 0
            } else {
                return self._locStarSec
            }
        }
        set(startSec) {
            if let id = self.identifier {
                CountDownButton._timestampMap[id] = startSec
            } else {
                self._locStarSec = startSec
            }
        }
    }
    private var _currSec: CFTimeInterval { return CACurrentMediaTime() }
    
    private func _startTimer() {
        _timer?.invalidate()
        let timer = Timer(timeInterval: self.timeInterval, target: self, selector: #selector(_onTimerCountDown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        timer.fire()
        _timer = timer
        
        self.isUserInteractionEnabled = false
        self.onStartCountDown?(self)
    }
    
    private func _stopTimer() {
        _timer?.invalidate()
        
        self.isUserInteractionEnabled = true
        self.onStopCountDown?(self)
    }
    
    // MARK: Action
    @objc private func _onTimerCountDown() {
        if self.remainSec > 0 {
            self.onCountDown?(self)
        } else {
            self.stopCountDown()
        }
    }
}
