//
//  UIFontExtensions.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/24.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import UIKit

extension UIFont {
    //SFUIText-Light
    //SFUIText
    //SFUIText-Semibold
    var light: UIFont {
        var name = ""
        if #available(iOS 9.0, *) {
            name = ".SFUIText-Light"
        } else {
            name = "HelveticaNeue-Light"
        }
        let f = UIFont(name: name, size: self.pointSize)
        return f!.autoScaled()
    }
    
    var bold: UIFont {
        let f = UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold) ?? self.fontDescriptor, size: self.pointSize)
        return f.autoScaled()
    }
    
    static let font7 = UIFont.normalFont.withSize(7).autoScaled()
    static let font8 = UIFont.normalFont.withSize(8).autoScaled()
    static let font9 = UIFont.normalFont.withSize(9).autoScaled()
    static let font10 = UIFont.normalFont.withSize(10).autoScaled()
    static let font11 = UIFont.normalFont.withSize(11).autoScaled()
    static let font12 = UIFont.normalFont.withSize(12).autoScaled()
    static let font13 = UIFont.normalFont.withSize(13).autoScaled()
    static let font14 = UIFont.normalFont.withSize(14).autoScaled()
    static let font15 = UIFont.normalFont.withSize(15).autoScaled()
    static let font16 = UIFont.normalFont.withSize(16).autoScaled()
    static let font17 = UIFont.normalFont.withSize(17).autoScaled()
    static let font18 = UIFont.normalFont.withSize(18).autoScaled()
    static let font19 = UIFont.normalFont.withSize(19).autoScaled()
    static let font20 = UIFont.normalFont.withSize(20).autoScaled()
    static let font21 = UIFont.normalFont.withSize(21).autoScaled()
    static let font22 = UIFont.normalFont.withSize(22).autoScaled()
    static let font23 = UIFont.normalFont.withSize(23).autoScaled()
    static let font24 = UIFont.normalFont.withSize(24).autoScaled()
    static let font25 = UIFont.normalFont.withSize(25).autoScaled()
    static let font26 = UIFont.normalFont.withSize(26).autoScaled()
    static let font27 = UIFont.normalFont.withSize(27).autoScaled()
    static let font28 = UIFont.normalFont.withSize(28).autoScaled()
    static let font29 = UIFont.normalFont.withSize(29).autoScaled()
    static let font30 = UIFont.normalFont.withSize(30).autoScaled()
    static let font31 = UIFont.normalFont.withSize(31).autoScaled()
    static let font32 = UIFont.normalFont.withSize(32).autoScaled()
    static let font33 = UIFont.normalFont.withSize(33).autoScaled()
    static let font34 = UIFont.normalFont.withSize(34).autoScaled()
    static let font35 = UIFont.normalFont.withSize(35).autoScaled()
    static let font45 = UIFont.normalFont.withSize(45).autoScaled()

    
    private func autoScaled() -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: self)
        } else {
            return self
        }
    }
    private static let normalFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
}
