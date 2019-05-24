//
//  View.swift
//

import UIKit
import Driftwood


class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStyle()
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// setup style
    func setupStyle() {}
    
    /// setup layout
    func setupLayout() {}
}
