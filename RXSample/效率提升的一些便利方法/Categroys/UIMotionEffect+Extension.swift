//
//  File.swift
//  pgysdk
//
//  Created by 梁泽 on 2019/5/7.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit

extension UIMotionEffect {
    ///浮动
    static func makeDriftMotionEffect() -> UIMotionEffect {
        let horizontalEffect = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: .tiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = -16
        horizontalEffect.maximumRelativeValue = 16
        
        let verticalEffect = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: .tiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = -16
        verticalEffect.maximumRelativeValue = 16
        
        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [ horizontalEffect,
                                      verticalEffect ]
        return effectGroup
    }
    ///keyPaths正在调整图层的阴影偏移值; 最小值和最大值范围被反转，这会导致阴影的运动与设备的物理运动相反
    static func makeShadowOffsetMotionEffect() -> UIMotionEffect {
        let horizontalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.width",
            type: .tiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = 16
        horizontalEffect.maximumRelativeValue = -16
        
        let verticalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.height",
            type: .tiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = 16
        verticalEffect.maximumRelativeValue = -16
        
        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [ horizontalEffect,
                                      verticalEffect ]
        
        return effectGroup
    }
    ///它接受一个CGPath对象，该对象可用于定义复杂的贝塞尔曲线路径。该层将自动插入最小和最大路径之间的中间状态，允许陀螺仪在设备旋转时调整阴影。
    static func makeShadowPathMotionEffect(for contentView: UIView) -> UIMotionEffect {
        let size = contentView.bounds.size
        let minimumPath = UIBezierPath()
        minimumPath.move(to: CGPoint(x: size.width * 0.33,
                                     y: size.height * 0.66))
        minimumPath.addLine(to: CGPoint(x: size.width * 0.66,
                                        y: size.height * 0.66))
        minimumPath.addLine(to: CGPoint(x: size.width * 1.15,
                                        y: size.height * 1.15))
        minimumPath.addLine(to: CGPoint(x: size.width * -0.15,
                                        y: size.height * 1.15))
        minimumPath.close()
        
        let maximumPath = UIBezierPath(rect: CGRect(origin: .zero, size: size))
        
        let effect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowPath",
            type: .tiltAlongVerticalAxis)
        effect.minimumRelativeValue = minimumPath.cgPath
        effect.maximumRelativeValue = maximumPath.cgPath
        
        return effect
    }
    
    ///可以更改图层的整个转换属性，从而实现视图层次结构的真实3D转换 ，将视图围绕视图的X轴旋转45º。
    static func makeTransform3DMotionEffect(for contentView: UIView) -> UIMotionEffect {
        var identity = CATransform3DIdentity
        identity.m34 = -1 / 500.0
        let minimum = CATransform3DRotate(identity, (315 * .pi) / 180.0, 1.0, 0.0, 0.0)
        let maximum = CATransform3DRotate(identity, (45 * .pi) / 180.0, 1.0, 0.0, 0.0)

        contentView.layer.transform = identity
        let effect = UIInterpolatingMotionEffect(
            keyPath: "layer.transform",
            type: .tiltAlongVerticalAxis)
        effect.minimumRelativeValue = minimum
        effect.maximumRelativeValue = maximum
        
        return effect
    }
}
