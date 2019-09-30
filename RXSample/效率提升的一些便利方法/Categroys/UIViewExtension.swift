//
//  File.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2019/2/19.
//  Copyright © 2019 com.FBBC.JoinTown. All rights reserved.
//

import UIKit

//为 uiview 扩展添加边框功能
extension UIView {
    //画线
    private func drawBorder(rect:CGRect,color:UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    //设置右边框
    public func addRightBorder(width:CGFloat,borderColor:UIColor){
        let lineView = UIView(color: borderColor)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(width)
        }
    }
    //设置左边框
    public func addLeftBorder(width:CGFloat,borderColor:UIColor){
        let lineView = UIView(color: borderColor)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(width)
        }
    }
    
    //设置上边框
    public func addTopBorder(width:CGFloat,borderColor:UIColor){
        let lineView = UIView(color: borderColor)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(width)
        }
    }
    
    
    //设置底边框
    public func addBottomBorder(width:CGFloat,borderColor:UIColor){
        let lineView = UIView(color: borderColor)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(width)
        }
    }
}

//MARK:- 响应链
extension UIView {
    var viewController: UIViewController? {
        var next = self.next
        while next != nil {
            if let next = next as? UIViewController {
                return next
            }
            next = next?.next
        }
        return nil
    }
    
    func superDesignationView(_ aClass: AnyClass) -> UIResponder? {
        var next = self.next
        while next != nil {
            if let next = next, next.isMember(of: aClass) {
                return next
            }
            next = next?.next
        }
        return nil
    }
}

//MARK:- 切单边圆角
extension UIView{
    @objc func mask(corners: UIRectCorner, radius: CGFloat){
        mask(corners: corners, cornerRdii: CGSize(width: radius, height: radius))
    }
    
    @objc func mask(corners: UIRectCorner, cornerRdii: CGSize){
        DispatchQueue.main.async {
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRdii)
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
    }
}
