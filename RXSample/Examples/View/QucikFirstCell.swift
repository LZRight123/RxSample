//
//  QucikFirstCell.swift
//  RXSample
//
//  Created by liangze on 2019/9/30.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class QucikFirstCell: BaseCell {
    private let titleLabel = UILabel(font: .font14, textColor: .hex666666, numberOfLines: 0)
    private let rightImgView = UIImageView(color: .random)

    override func setupUI() {
        addSubviews(titleLabel, rightImgView, lineView)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(baseSpace)
            $0.right.equalTo(self.rightImgView.snp.left).offset(-baseSpace)
            $0.top.equalToSuperview().offset(baseSpace)
            $0.bottom.equalToSuperview().offset(-baseSpace)
        }
        
        rightImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-baseSpace)
            $0.width.equalTo(17)
            $0.height.equalTo(20)
        }
        
        lineView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(baseSpace)
            $0.bottom.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}

extension QucikFirstCell {
    func bind(_ model: Int) {}
    func bind(_ model: Double) {} //自定义的其它model? ??

    func bind(_ model: String) {
        titleLabel.text = model
    }
}
