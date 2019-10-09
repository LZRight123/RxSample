//
//  UIViewController+Swizzle.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/23.
//

import UIKit

extension UIViewController {
    private static var hasSwizzled = false
    
    /// 交换方法
    @objc public class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        hasSwizzled = true
        
        swizzle(self, sels:
            [
                (#selector(self.viewDidLoad),
                 #selector(self.jr_viewDidLoad)),
                
                (#selector(self.viewWillAppear(_:)),
                 #selector(self.jr_viewWillAppear(_:))),
                
                (#selector(self.traitCollectionDidChange(_:)),
                 #selector(self.jr_traitCollectionDidChange(_:))),
                
                (#selector(self.performSegue(withIdentifier:sender:)),
                 #selector(self.jr_performSegueWithIdentifier(identifier:sender:)))
            ]
        )
    }
    
    /// 绑定VM
    @objc open func jr_bindViewModel() {}
    /// UI设置
    @objc open func jr_setupUI() {}
    /// UI控件处理事件
    @objc open func jr_setupEvent() {}
    /// UI控件布局
    @objc open func jr_setupLayout() {}
    /// UI导航栏处理
    @objc open func jr_setupNavigationBar() {}
    
    @objc internal func jr_viewDidLoad() {
        self.jr_viewDidLoad()
        jr_setupUI()
        jr_setupEvent()
        
        jr_bindViewModel()
    }
    
    @objc internal func jr_viewWillAppear(_ animated: Bool) {
        self.jr_viewWillAppear(animated)
        
        if !hasViewAppeared {
            hasViewAppeared = true
            
            jr_setupLayout()
            jr_setupNavigationBar()
        }
    }
    
    @objc internal func jr_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.jr_traitCollectionDidChange(previousTraitCollection)
        jr_setupLayout()
    }
    
    @objc internal func jr_init(nibName: String?, bundle: Bundle?) -> UIViewController {
        let controller = self.jr_init(nibName: nibName, bundle: bundle)
        return controller
    }
    
    /// 防止VC多次push
    @objc internal func jr_performSegueWithIdentifier(identifier: String, sender: Any?) {
        if let navigationController = navigationController {
            guard navigationController.topViewController == self else {
                return
            }
        }
        self.jr_performSegueWithIdentifier(identifier: identifier, sender: sender)
    }
}

extension UIViewController {
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
