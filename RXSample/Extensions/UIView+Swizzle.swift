
//
//  UIView+Swizzle.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/23.
//

import UIKit

// MARK: - UIView
extension UIView {
    private static var hasSwizzled = false
    
    @objc public class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        hasSwizzled = true
        swizzle(self, sels:
            [
                (#selector(self.traitCollectionDidChange(_:)),
                 #selector(self.jr_traitCollectionDidChange(_:))),
                
                (#selector(self.layoutSubviews),
                 #selector(self.jr_layoutSubviews)),
                
                (#selector(self.init(frame:)),
                 #selector(self.jr_init(frame:)))
            ]
        )
    }
    
    @objc open func jr_bindViewModel() {}
    
    @objc open func jr_setupUI() {}
    @objc open func jr_setupEvent() {}
    @objc open func jr_setupLayout() {}
    
    @objc internal func jr_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection) {
        self.jr_traitCollectionDidChange(previousTraitCollection)
        jr_setupLayout()
    }
    
    @objc internal func jr_layoutSubviews() {
        self.jr_layoutSubviews()
        if !hasViewAppeared {
            hasViewAppeared = true
            
            jr_setupLayout()
        }
    }
    
    @objc internal func jr_init(frame: CGRect) -> UIView {
        let view = self.jr_init(frame: frame)
        /// UITableViewCell UICollectionViewCell 有自己单独的初始化方法，不在此处做方法交换
        guard !(self is UITableViewCell || self is UICollectionViewCell) else {
            return view
        }
        jr_setupUI()
        jr_setupEvent()
        
        jr_bindViewModel()
        return view
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }
    
    /// 是否显示过, 默认为false
    private var hasViewAppeared: Bool {
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.hasViewAppeared,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared)
                as? Bool ?? false
        }
    }
}


// MARK: - UITableViewCell

extension UITableViewCell {
    private static var hasSwizzled = false
    
    @objc public override class func doBadSwizzleStuff() {
        /// 保证先hook父类的方法，不会方法交换错误
        super.doBadSwizzleStuff()
        guard !hasSwizzled else { return }
        hasSwizzled = true
        
        swizzle(self, sels: [
            (#selector(self.init(style:reuseIdentifier:)),
             #selector(self.jr_init(style:reuseIdentifier:))),
            (#selector(self.setSelected(_:animated:)),
             #selector(self.jr_setSelected(_:animated:)))
            ]
        )
    }
    
    @objc open override func jr_setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
    }
    
    @objc internal func jr_init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) -> UITableViewCell {
        let cell = self.jr_init(style: style, reuseIdentifier: restorationIdentifier)
        jr_setupUI()
        jr_setupEvent()
        
        jr_bindViewModel()
        
        return cell
    }
    
    @objc internal func jr_setSelected(_ selected: Bool, animated: Bool) {
        self.jr_setSelected(selected, animated: animated)
    }
    
}

// MARK: - UICollectionCell

extension UICollectionViewCell {
    private static var hasSwizzled = false
    
    @objc public override class func doBadSwizzleStuff() {
        /// 保证先hook父类的方法，不会方法交换错误
        super.doBadSwizzleStuff()
        guard !hasSwizzled else { return }
        hasSwizzled = true
        
        swizzle(self, sels:
            [
                (#selector(self.init(frame:)),
                 #selector(self.jr_collectionCell_init(frame:)))
            ]
        )
    }
    
    @objc internal func jr_collectionCell_init(frame: CGRect) -> UICollectionViewCell {
        let cell = self.jr_collectionCell_init(frame: frame)
        jr_setupUI()
        jr_setupEvent()
        
        jr_bindViewModel()
        
        return cell
    }
    
}
