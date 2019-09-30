//
//  Double+Extension.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit


extension Double
{
    func format(_ f: String) -> String {
        return String(format: "%\(f)", self)
    }
    
    var numberFormat: String {
//        let num = NSDecimalNumber(string: self.format("f"))
//        return num?.stringValue ?? ""        
        let format = NumberFormatter()
        format.positiveFormat = "0.##;"
        return format.string(for: self) ?? ""
    }
    
    func formatCustom(_ positive: String) -> String {
        let format = NumberFormatter()
        format.positiveFormat = positive
        return format.string(for: self) ?? ""
    }
    
    public var toString: String { return String(self) }
    public var toInt: Int { return Int(self) }
    public var toCGFloat: CGFloat { return CGFloat(self) }
}



