//
//  Animation.swift
//  AnimatorExcample
//
//  Created by 梁泽 on 2019/4/4.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit

public struct Animation {
    var duration: TimeInterval
    public let closure: (UIView) -> Void
}

public extension Animation {
    static func fadeIn(_ duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    static func fadeOut(_ duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 0 })
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.bounds.size = size })
    }
    
    static func move(byX x: CGFloat, y: CGFloat, duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration) {
            $0.center.x += x
            $0.center.y += y
        }
    }
    
    static func scale(to scale: CGFloat, duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.transform = CGAffineTransform(scaleX: scale, y: scale) })
    }
    
    static func scale(toScaleX scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.transform = CGAffineTransform(scaleX: scaleX, y: scaleY) })
    }
    
    static func removeTransform(duration: TimeInterval = 0.25) -> Animation {
        return Animation(duration: duration, closure: { $0.transform = .identity })
    }
    
    static func custom(duration: TimeInterval = 0.25, closure: @escaping (UIView) -> Void) -> Animation {
        return Animation(duration: duration, closure: closure)
    }
}

public extension UIView {
    func performAnimations(_ animations: [Animation], completionHander: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return completionHander()
        }
        
        let animationCount = animations.count
        var completionCount = 0
        
        let animationCompletionHandler = {
            completionCount += 1
            
            if completionCount == animationCount {
                completionHander()
            }
        }
        
        for animation in animations {
            UIView.animate(withDuration: animation.duration, animations: {
                animation.closure(self)
            }, completion: { _ in
                animationCompletionHandler()
            })
        }
    }
    
    func performAnimationsInSerial(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        guard !animations.isEmpty else {
            return
        }
        
        var tempAnimations = animations
        let animation = tempAnimations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }) { (_) in
            self.performAnimations(tempAnimations, completionHander: completionHandler)
        }
    }
}

