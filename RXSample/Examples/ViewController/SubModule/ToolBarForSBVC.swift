//
//  ToolBarForSBVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/8.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class ToolBarForSBVC: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let btn = UIButton(font: .font14, title: "click me show wrap", titleColor: .white)
        btn.backgroundColor = .random
        view.addSubview(btn)
        btn.snp.makeConstraints{ $0.center.equalToSuperview() }
        
        btn.rx.tap
            .subscribe(onNext: { [unowned self] in
                 let nextVC = WrapVC.buildVC()
                 self.present(nextVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
