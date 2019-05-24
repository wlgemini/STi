//
//  UIView+CreateSubView.swift
//

import UIKit


extension UIView {
    
    /// Create subview
    public func createSubview<V: UIView>() -> V? {
        let v = V(frame: .zero)
        self.addSubview(v)
        return v
    }
    
    /// Create sub UITableView
    public func createSubTableView(style: UITableView.Style = .plain) -> UITableView {
        let v = UITableView(frame: CGRect.zero, style: style)
        self.addSubview(v)
        return v
    }
    
    /// Create & add sub UICollectionView
    public func createSubCollectionView(layout: UICollectionViewLayout = {
        let ly = UICollectionViewFlowLayout()
        ly.scrollDirection = .vertical
        return ly
        }()) -> UICollectionView {
        
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.addSubview(v)
        return v
    }
}


extension UIView {
    
    /// Create SubLayoutGuide
    public func createSubLayoutGuide() -> UILayoutGuide {
        let g = UILayoutGuide()
        self.addLayoutGuide(g)
        return g
    }
}


extension UIStackView {
    
    /// Create arranged view
    ///
    /// - Returns: New generic-type view
    public func createArrangedView<V: UIView>() -> V? {
        let v = V()
        self.addArrangedSubview(v)
        return v
    }
}

