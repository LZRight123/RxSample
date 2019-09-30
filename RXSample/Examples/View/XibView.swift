
//
//  XibView.swift
//  RXSample
//
//  Created by liangze on 2019/9/30.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class XibView: UIView {
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var four: UILabel!
    @IBOutlet weak var five: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [one, two, three, four, five]
            .forEach{
                $0?.text = String.randomString(Int.random(in: 10...30))
            }
    }

}
