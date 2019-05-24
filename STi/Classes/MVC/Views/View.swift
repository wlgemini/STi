//
//  View.swift
//

import UIKit
import DriftwoodHandily


open class View: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStyle()
        self.setupLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setup style
    open func setupStyle() {}
    
    /// setup layout
    open func setupLayout() {}
}
