//
//  SSVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/11.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
@_exported import SegementSlide

class SSVC: SegementSlideViewController {
    let disposeBag = DisposeBag()

    var vcs: [SegementSlideContentScrollViewDelegate] = [OneVC()];
    
    lazy var oneVC: SegementSlideContentScrollViewDelegate = OneVC()
    lazy var twoVC: SegementSlideContentScrollViewDelegate = TwoVC()
    
    
    override var titlesInSwitcher: [String] {
        return vcs.map{ $0.title ?? "设置title" }
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return vcs[index]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollToSlide(at: 0, animated: true)
        reloadData()
        
        
        bind()
    }
    
    private func bind() {
        let ov = vcs[0] as! OneVC
        ov.clickRow
            .subscribe { [unowned self] _ in
                self.clickOne()
            }
            .disposed(by: disposeBag)
    }
    
    private func clickOne() {
        if vcs.count == 1 {
            vcs.append(twoVC)
            reloadData()

            scrollToSlide(at: 1, animated: true)
        } else {
            scrollToSlide(at: 1, animated: true)
        }
    }
    

}
