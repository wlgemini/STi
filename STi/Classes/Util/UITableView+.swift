//
//  UITableView+.swift
//

import UIKit


extension UITableView {
    
    @available(iOS 6.0, *)
    open func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        self.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    @available(iOS 6.0, *)
    open func registerHeaderFooterView<HeaderFooterView: UITableViewHeaderFooterView>(_ headerFooterView: HeaderFooterView.Type) {
        self.register(HeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderFooterView.reuseIdentifier)
    }
    
    open func dequeueReusableCell<Cell: UITableViewCell>() -> Cell? {
        return self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell
    }
    
    @available(iOS 6.0, *)
    open func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
    
    @available(iOS 6.0, *)
    open func dequeueReusableHeaderFooterView<HeaderFooterView: UITableViewHeaderFooterView>() -> HeaderFooterView? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterView.reuseIdentifier) as? HeaderFooterView
    }
}
