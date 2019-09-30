//
//  LZTransitioningAnimate.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/24.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import UIKit

@objc class AnimatorOC: NSObject {
    @objc static let present = LZPresentTransitioningAnimate()
//    @objc static let presentNoBackground = TransitioningAnimateNoBackgroundPresent()
    @objc static let popup = LZPopupTransitioningAnimate()
}

class LZTransitioningAnimate: NSObject {
    struct Animator {
        static let present = LZPresentTransitioningAnimate()
        static let popup  =  LZPopupTransitioningAnimate()
    }
    
    var duration: TimeInterval = 0.25
}

//MARK: UIViewControllerTransitioningDelegate
extension LZTransitioningAnimate: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return LZPresentationControlller(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

//MARK: UIViewControllerAnimatedTransitioning
extension LZTransitioningAnimate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //FIXME: -subclass implement
    }
}
