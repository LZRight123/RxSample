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
    
    
    let vcs: [SegementSlideContentScrollViewDelegate] = [OneVC(), TwoVC()];
    
    override var titlesInSwitcher: [String] {
        return ["1111", "22222"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return vcs[index]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollToSlide(at: 0, animated: true)
        reloadData()
    }
    

}
