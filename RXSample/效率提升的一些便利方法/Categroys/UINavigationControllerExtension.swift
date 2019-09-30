//
//  File.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/12/24.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

extension UINavigationController {
    @objc func getvc(_ aClass: AnyClass) -> UIViewController? {
        return viewControllers.filter{ $0.isMember(of: aClass) }.first
    }
    
    @objc func getvc(stackIndex: Int) -> UIViewController? {
        if stackIndex >= viewControllers.count {
            return nil
        }
        return viewControllers[viewControllers.count - 1 - stackIndex]
    }
    
    @objc func push(_ toVC: UIViewController, popMiddle beforeVC: UIViewController, before: Int = 0, animation: Bool = true) {
        pushViewController(toVC, animated: animation)
        
        if let i = viewControllers.firstIndex(where: { $0 == beforeVC }) {
            let index = max(0, i - before)
            var controllers = Array(viewControllers[0...(index)])
            controllers.append(toVC)
            viewControllers = controllers
        }
    }
    
    @objc func popFromStack(_ vc: UIViewController) {
        viewControllers = viewControllers.filter { $0 != vc }
    }
}
