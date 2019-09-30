//
//  Animator.swift
//  AnimatorExcample
//
//  Created by 梁泽 on 2019/4/4.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit

public final class Animator {
    enum AnimationMode {
        /// 串行
        case inSerial
        /// 并行
        case inConcurrent
    }
    
    var view: UIView
    var animations: [Animation]
    var mode: AnimationMode
    var isValid = true
    
    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        perform { }
    }
    
    func perform(completionHander: @escaping () -> Void) {
        guard isValid else {
            return
        }
        
        isValid = false
        
        switch mode {
        case .inSerial:
            view.performAnimationsInSerial(animations, completionHandler: completionHander)
        case .inConcurrent:
            view.performAnimations(animations, completionHander: completionHander)
        }
        
    }
}

public extension Animator {
    static func animation(_ animators: [Animator]) {
        guard !animators.isEmpty else {
            return
        }
        
        var tempAnimators = animators
        let animator = tempAnimators.removeFirst()
        
        animator.perform {
            animation(tempAnimators)
        }
    }
    
    static func animation(_ animators: Animator ...) {
        animation(animators)
    }
}

public extension UIView {
    @discardableResult func animate(_ animations: [Animation]) -> Animator {
        return Animator(view: self, animations: animations, mode: .inConcurrent)
    }
   
    @discardableResult func animate(inSerial animations: [Animation]) -> Animator {
        return Animator(view: self, animations: animations, mode: .inSerial)
    }
    
    @discardableResult func animate(_ animations: Animation...) -> Animator {
        return animate(animations)
    }
    
    @discardableResult func animate(inSerial animations: Animation...) -> Animator {
        return animate(inSerial: animations)
    }
}

