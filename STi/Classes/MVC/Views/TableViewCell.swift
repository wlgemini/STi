//
//  TableViewCell.swift
//

import UIKit
import Driftwood


open class TableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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


extension TableViewCell {
    
    /// reuseIdentifier
    public static var reuseIdentifier: String { return String(describing: self) }
}
