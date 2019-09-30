//
//  UIViewExtension.swift
//  Sundell
//
//  Created by 梁泽 on 2019/4/5.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit
import ObjectiveC
//https://nshipster.com/ibinspectable-ibdesignable/

//@IBDesignable
public extension UIView {
    private struct AssociatedKeys {
        static var shadowMotionOffset: UInt8 = 0
        static var motionOffset: UInt8 = 0
    }
        
    @objc @IBInspectable var cornerRadius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set(radius) {
            layer.cornerRadius = radius
        }
    }
    
    @objc @IBInspectable var masksToBounds : Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @objc @IBInspectable var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set(width) {
            layer.borderWidth = width
        }
    }
    
    @objc @IBInspectable var borderColor : UIColor? {
        get {
            return layer.borderColor as? UIColor? ?? nil
        }
        set(color) {
            layer.borderColor = color?.cgColor
        }
    }
    
    @objc @IBInspectable var shadowColor : UIColor? {
        get {
            return layer.shadowColor as? UIColor? ?? nil
        }
        set(color) {
            layer.shadowColor = color?.cgColor
        }
    }
    
    @objc @IBInspectable var shadowRadius : CGFloat {
        get {
            return layer.shadowRadius
        }
        set(radius) {
            layer.shadowRadius = radius
        }
    }
    
    @objc @IBInspectable var shadowOpacity : Float {
        get {
            return layer.shadowOpacity
        }
        set(opacity) {
            layer.shadowOpacity = opacity
        }
    }
    
    @objc @IBInspectable var shadowOffset : CGSize {
        get {
            return layer.shadowOffset
        }
        set(offset) {
            layer.shadowOffset = offset
        }
    }
    
    @objc @IBInspectable var shadowMotionOffset : CGSize {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.shadowMotionOffset) as? NSValue else {
                return .zero
            }
            
            return value.cgSizeValue
        }
        set(newSize) {
            var currentSize = CGSize.zero
            let currentValue = objc_getAssociatedObject(self, &AssociatedKeys.shadowMotionOffset) as? NSValue
            if currentValue != nil {
                currentSize = currentValue!.cgSizeValue
            }
            
            if currentSize.equalTo(newSize) {
                return
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.shadowMotionOffset, NSValue(cgSize: newSize), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            addInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", effectType: .tiltAlongHorizontalAxis, range: newSize.width)
            addInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", effectType: .tiltAlongVerticalAxis, range: newSize.height)
        }
    }
    
    @objc @IBInspectable var motionOffset : CGSize {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.motionOffset) as? NSValue else {
                return .zero
            }
            
            return value.cgSizeValue
        }
        set(newSize) {
            var currentSize = CGSize.zero
            let currentValue = objc_getAssociatedObject(self, &AssociatedKeys.motionOffset) as? NSValue
            if currentValue != nil {
                currentSize = currentValue!.cgSizeValue
            }
            
            if currentSize.equalTo(newSize) {
                return
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.motionOffset, NSValue(cgSize: newSize), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            addInterpolatingMotionEffect(keyPath: "center.x", effectType: .tiltAlongHorizontalAxis, range: newSize.width)
            addInterpolatingMotionEffect(keyPath: "center.y", effectType: .tiltAlongVerticalAxis, range: newSize.height)
        }
    }
    
    private func addInterpolatingMotionEffect(keyPath : String, effectType : UIInterpolatingMotionEffect.EffectType, range value : CGFloat) {
        for effect in motionEffects {
            if let interpolatingEffect = effect as? UIInterpolatingMotionEffect {
                if interpolatingEffect.keyPath == keyPath {
                    removeMotionEffect(interpolatingEffect)
                    break
                }
            }
        }
        
        if value == 0 {
            return
        }
        
        let effect = UIInterpolatingMotionEffect(keyPath: keyPath, type: effectType)
        if value < 0 {
            effect.minimumRelativeValue = -(abs(value));
            effect.maximumRelativeValue = abs(value);
        } else {
            effect.minimumRelativeValue = abs(value);
            effect.maximumRelativeValue = -(abs(value));
        }
        addMotionEffect(effect)
    }
}


//@IBDesignable
public extension UITextField {
    @objc @IBInspectable var aplaceholderColor: UIColor? {
        get {
            return nil
        }
        set {
            guard let color = aplaceholderColor else { return }
            
            if let attributedPlaceholder = attributedPlaceholder {
                let text = NSMutableAttributedString(attributedString: attributedPlaceholder)
                text.addAttributes([.foregroundColor : color], range: NSRange(location: 0, length: attributedPlaceholder.string.count))
                self.attributedPlaceholder = text
            }
            
            guard let placeholder = placeholder else { return }
            
            let text = NSAttributedString(string: placeholder, attributes: [
                .foregroundColor : color
                ])
            attributedPlaceholder = text
        }
    }
}

class IBUIView: UIView {}
class IBUIButton: UIButton {}
class IBUILabel: UILabel {}
class IBUITextFiled: UITextField {}
