//
//  LZToolBar.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/23.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import UIKit

@IBDesignable
class LZToolBar: UIView {
    private var effectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.isHidden = true
        return view
    }()
    private let backgroundImageView = UIImageView()
    
    let safeAreaView = UIImageView()
    var didTouchToolbar: (() -> Void)?
    
    override var backgroundColor: UIColor?  {
        didSet{
            backgroundImageView.backgroundColor = backgroundColor
        }
    }
    
    @IBInspectable var translucent = false {
        didSet{
            effectView.isHidden = !translucent
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet{
            backgroundImageView.image = backgroundImage
        }
    }
    
    @IBInspectable var effectSyle = UIBlurEffect.Style.extraLight {
        didSet{
            effectView.effect = nil
            effectView.effect = UIBlurEffect(style: effectSyle)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

   
    func commonInit() {
        insertSubview(safeAreaView, at: 0)
        insertSubview(effectView, at: 0)
//        addSubview(backgroundImageView)
        insertSubview(backgroundImageView, at: 0)
//        addSubview(effectView)
//        addSubview(safeAreaView)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(SafeBottomArea)
        }
        
        safeAreaView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.bottom)
            make.height.equalTo(SafeBottomArea)
        }
        
        effectView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.backgroundImageView)
        }
    }    
}

//MARK: - 交互
extension LZToolBar {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var touchBound = bounds
        touchBound.size.height = bounds.height + 34.0
        return touchBound.contains(point)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let block = self.didTouchToolbar {
            block()
        }
    }
}
