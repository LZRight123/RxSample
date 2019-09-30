//
//  NibLoadable.swift
//  Sundell
//
//  Created by 梁泽 on 2019/4/6.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit
//MARK:- 协议
public protocol NibLoadable: class { }

public protocol DequeueReusableCell: class { }

//MARK:- UI 扩展
public extension UIView {
    static var identifier: String { return String(describing: self) }
    
    static var nibName: String { return String(describing: self) }
    
    static var nib: UINib { return UINib(nibName: nibName, bundle: Bundle(for: self)) }
}
public extension UIViewController {
    static var identifier: String { return String(describing: self) }
    
    static var nibName: String { return String(describing: self) }
}
extension UIView: NibLoadable { }
extension UIViewController: NibLoadable { }

public extension UITableView {
    func regiseter(nib cellClass: UITableViewCell.Type) {
        register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func regiseter(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}
extension UITableViewCell: DequeueReusableCell {}

public extension UICollectionView {
    func regiseter(nib cellClass: UICollectionViewCell.Type) {
        register(cellClass.nib, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    func regiseter(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
}
extension UICollectionViewCell: DequeueReusableCell {}

//MARK:- 协议扩展
public extension NibLoadable where Self: UIView {
    static func fromNib() -> Self {
        guard let nib = Bundle(for: self).loadNibNamed(nibName, owner: nil, options: nil) else {
            fatalError("Failed loading the nib named \(nibName) for 'NibLoadable' view of type '\(self).'")
        }
        guard let view = nib.first as? Self else {
            fatalError("Did`t find 'NibLoadable' view of type '\(self).' inside '\(nibName).xib .'")
        }
        return view
    }
}

public extension NibLoadable where Self: UIViewController {
    static func fromSb(_ name: String) -> Self {
        let sb = UIStoryboard(name: name, bundle: Bundle(for: self))
        guard let vc = sb.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("ViewController of type '\(self).' inside '\(identifier).sb is nil?.'")
        }
        return vc
    }
    
    static func fromNib() -> Self {
        let vc = self.init(nibName: nibName, bundle: Bundle(for: self)) as Self
        return vc
    }
}

public extension DequeueReusableCell where Self: UITableViewCell {
    static func dequeueReusable(for talbeView: UITableView) -> Self {
        guard let cell = talbeView.dequeueReusableCell(withIdentifier: identifier) as? Self else {
            fatalError("view of type '\(self).' inside '\(nibName).xib is nil?.'")
        }
        return cell
    }
    
    static func dequeueReusable(for talbeView: UITableView, indexPath: IndexPath) -> Self {
        guard let cell = talbeView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Self else {
            fatalError("view of type '\(self).' inside '\(nibName).xib is nil?.'")
        }
        return cell
    }
}

public extension DequeueReusableCell where Self: UICollectionViewCell {
    static func dequeueReusable(for collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self else {
            fatalError("view of type '\(self).' inside '\(nibName).xib is nil?.'")
        }
        return cell
    }
}
