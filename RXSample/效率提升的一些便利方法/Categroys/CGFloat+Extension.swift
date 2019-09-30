//
//  CGFloat+Extension.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit

extension CGFloat {
    public var degreesToRadians: CGFloat {
        return (.pi * self) / 180.0
    }
    
    public var radiansToDegress: CGFloat {
        return (180.0 * self) / .pi
    }
   
    public var toInt: Int { return Int(self) }
    public var toDouble: Double { return Double(self) }
    public var toString: String { return "\(self)" }
}
