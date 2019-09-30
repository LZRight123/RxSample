//
//  GlobalParameter.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit

let ScreenWidth  = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let StatusBarH   = UIApplication.shared.statusBarFrame.height
let ISIphoneX  = (StatusBarH == 44)
let SafeBottomArea: CGFloat = (ISIphoneX ? 34 : 0)
let ScaleW = ScreenWidth/375.0
let TagCommont = 100
