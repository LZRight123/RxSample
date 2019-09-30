//
//  Int+Extension.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit

extension Int
{
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
    public var toDouble: Double { return Double(self) }
    public var toFloat: Float { return Float(self) }
    public var toCGFloat: CGFloat { return CGFloat(self) }
    public var toString: String { return String(self) }
    public var toUInt: UInt { return UInt(self) }    
    public var toInt32: Int32 { return Int32(self) }

}
