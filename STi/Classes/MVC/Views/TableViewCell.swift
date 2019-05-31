//
//  TableViewCell.swift
//

import UIKit
import DriftwoodHandily


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
