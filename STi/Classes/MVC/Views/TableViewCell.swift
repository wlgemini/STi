//
//  TableViewCell.swift
//

import UIKit
import Driftwood


class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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


extension TableViewCell {
    
    /// reuseIdentifier
    static var reuseIdentifier: String { return String(describing: self) }
}
