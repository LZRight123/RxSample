//
//  UIColor+Extension.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit

extension UIColor
{
    static let main = UIColor.hexFF6F21
    static let peise = UIColor.hex545a63
    static let jiage = UIColor.hexFA0200
    static let beijinghui = UIColor.hexF6F6F6
    static let fengeXian = UIColor.hexE5E5E5
    //MARK:- 设计规范3.3.0常用色
    static let hexFF6F21 = #colorLiteral(red: 1, green: 0.4352941176, blue: 0.1294117647, alpha: 1)
    static let hex545a63 = #colorLiteral(red: 0.3294117647, green: 0.3529411765, blue: 0.3882352941, alpha: 1)
    static let hexFA0200 = #colorLiteral(red: 0.9803921569, green: 0.007843137255, blue: 0, alpha: 1)
    static let hexF6F6F6 = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    static let hexE5E5E5 = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
    //MARK:- 设计规范3.3.0字体色
    static let hex000000 = UIColor.black
    static let hex222222 = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    static let hex444444 = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
    static let hex666666 = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    static let hex999999 = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    static let hexBEBEBE = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    //MARK:- ????
    static let hexEEEEEE = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    static let hexCCCCCC = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    static let hex050505 = #colorLiteral(red: 0.01960784314, green: 0.01960784314, blue: 0.01960784314, alpha: 1)
    static let hexF4F4F4 = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
    static let hexFDEADE = #colorLiteral(red: 0.9921568627, green: 0.9176470588, blue: 0.8705882353, alpha: 1)
    static let hex04BDE7 = #colorLiteral(red: 0.01568627451, green: 0.7411764706, blue: 0.9058823529, alpha: 1)
  
    static var random: UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let ri = String(format: "%2X", Int(r * 255))
        let gi = String(format: "%2X", Int(r * 255))
        let bi = String(format: "%2X", Int(r * 255))
        //        let ai = String(format: "%2X", Int(r * 255))
        return "#\(ri.count == 1 ? "0" + ri : ri)\(gi.count == 1 ? "0"+gi : gi)\(bi.count == 1 ? "0" + bi : bi)"
    }
    
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
