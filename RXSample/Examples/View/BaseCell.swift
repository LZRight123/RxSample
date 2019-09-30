//
//  BaseCell.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2019/1/9.
//  Copyright © 2019 com.FBBC.JoinTown. All rights reserved.
//


//MARK: - 只有一个lineView 给子类添加 子类可以直接写setupUI 开始创建UI  并提供UI基准 间隙
import UIKit

class BaseCell: UITableViewCell {
    lazy var lineView = UIView(color: UIColor.fengeXian)
    var baseSpace: CGFloat = 13 //UI设计的基准 间隙
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseCell {
    func showLineView(_ isShow: Bool) {
        lineView.isHidden = !isShow
    }
    
    @objc func setupUI() {
    }
}
