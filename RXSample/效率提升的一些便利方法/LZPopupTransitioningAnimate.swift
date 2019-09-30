//
//  LZPopupTransitioningAnimate.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/23.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import UIKit

class LZPopupTransitioningAnimate: LZTransitioningAnimate {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionContext.viewController(forKey: .to)?.isBeingPresented == true {
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: self.duration, animations: {
                toView?.transform = CGAffineTransform.identity
            }, completion: { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
//            UIView.animate(withDuration: self.duration * 0.8, animations: {
//                toView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//            }) { (_) in
//                UIView.animate(withDuration: self.duration * 0.1, animations: {
//                    toView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                }, completion: { (_) in
//                    UIView.animate(withDuration: self.duration * 0.1, animations: {
//                        toView?.transform = CGAffineTransform.identity
//                    }, completion: { (_) in
//                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                    })
//                })
//            }
        } else {
            UIView.animate(withDuration: duration * 0.8, animations: {
                transitionContext.view(forKey: .from)?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
}

