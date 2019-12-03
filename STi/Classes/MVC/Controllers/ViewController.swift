//
//  ViewController.swift
//

import UIKit
import PKHUD
import SwiftyNavigationBar
import Alamofire
import DriftwoodHandily

open class ViewController: UIViewController {
    
    /// invoked in `init` func
    open func willConfig() {
        self.hidesBottomBarWhenPushed = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    open func config() {}
    open func didConfig() {}
    
    /// invoked in `viewDidLoad` func
    open func willSetup() {}
    open func setupStyle() {}
    open func setupLayout() {}
    open func didSetup() {}
    
    /// init
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.willConfig()
        self.config()
        self.didConfig()
    }
    
    /// init
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// viewDidLoad
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.willSetup()
        self.setupStyle()
        self.setupLayout()
        self.didSetup()
    }
    
    // MARK: - Networking
    public func req<DS: DataStructure>(_ req: Request<DS>, param: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping (Alamofire.Result<DS.Value>) -> Void, line: Int = #line) {
        let req = Network.req(req, param: param, encoding: encoding, completion: completion)
        self._reqs[line] = req
    }
    
    /// deinit
    deinit {
        // remove noti
        self._removeNotification()
        
        // cancel req
        self._reqs.forEach({ $1.cancel() })
    }
    
    // MARK: - Private
    var _reqs: [Int: Alamofire.Request] = [:]
    
    private func _removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
}
