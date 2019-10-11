//
//  WrapVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/11.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class WrapVC: UIViewController {
    
    static func buildVC() -> WrapVC {
        let nextVC = WrapVC()
        nextVC.setupTransitioningAnimate(LZTransitioningAnimate.Animator.present)
        return nextVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ssvc = SSVC()
        ssvc.view.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
        add(ssvc)
        
        let toolBar = LZToolBar()
        toolBar.backgroundColor = .random
        view.addSubview(toolBar)
        
        toolBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.safeArea.bottom)
            $0.height.equalTo(44)
        }
        
        ssvc.view.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(toolBar.snp.top)
            $0.height.equalTo(300)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
}
