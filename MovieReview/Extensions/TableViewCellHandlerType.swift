//
//  TableViewCellHandlerType.swift
//  Doordash
//
//  Created by Mingze Xu on 5/3/19.
//  Copyright © 2019 Mingze Xu. All rights reserved.
//

import UIKit

/// UITableViewCell + Additions

public protocol IdentifiableCell {
    static var cellIdentifier: String { get }
}

public extension IdentifiableCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

public protocol IdentifiableNibBasedCell: IdentifiableCell {
    static func nib() -> UINib
}

public extension IdentifiableNibBasedCell {
    static func nib() -> UINib {
        return UINib(nibName: self.cellIdentifier, bundle: Bundle.main)
    }
}

/// UITableView + Additions
public extension UITableView {
    func registerIdentifiableCell<T: UITableViewCell>(_ cellClass: T.Type) where T: IdentifiableCell {
        if let nibBasedCell = cellClass as? IdentifiableNibBasedCell.Type {
            self.register(nibBasedCell.nib(), forCellReuseIdentifier: nibBasedCell.cellIdentifier)
        } else {
            self.register(cellClass, forCellReuseIdentifier: cellClass.cellIdentifier)
        }
    }
    
    func dequeuIdentifiableCell<T: IdentifiableCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier, for: indexPath) as! T
    }
}


/// UICollectionView + Additions
extension UICollectionReusableView: IdentifiableCell { }
public extension UICollectionView {
    
    public func registerCell<Cell>(_ cellType: Cell.Type) where Cell: UICollectionReusableView {
        if let type = cellType as? IdentifiableNibBasedCell.Type {
            let bundle = Bundle(for: cellType)
            self.register(UINib(nibName: type.cellIdentifier, bundle: bundle), forCellWithReuseIdentifier: type.cellIdentifier)
        } else {
            self.register(cellType, forCellWithReuseIdentifier: cellType.cellIdentifier)
        }
    }
    
    public func registerCells<Cell>(_ cellTypes: Cell.Type...) where Cell: UICollectionReusableView {
        for cellType in cellTypes {
            self.registerCell(cellType)
        }
    }
    
    public func dequeueCell<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UICollectionReusableView {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.cellIdentifier, for: indexPath) as! Cell
    }
    
}

