//
//  UIViewControllerExtensions.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/24.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation
//MARK:- 转场动画
extension UIViewController {
    @objc func setupTransitioningAnimate(_ animator: UIViewControllerTransitioningDelegate) {
        modalPresentationStyle = .custom
        transitioningDelegate = animator
    }
}

//MARK:- add remove
extension UIViewController {
    @discardableResult
    @objc func add(_ child: UIViewController) -> UIViewController {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        return child
    }
    
    func add(_ childs: UIViewController...) {
        childs.forEach { (child) in
            add(child)
        }
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

//MARK:- 获取当前vc
extension UIViewController {
    public static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}


