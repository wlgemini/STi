//
//  CollectionReusableView.swift
//

import UIKit
import Driftwood


class CollectionReusableView: UICollectionReusableView {
    
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


extension UICollectionReusableView {
    
    /// reuseIdentifier
    static var reuseIdentifier: String { return String(describing: self) }
}

