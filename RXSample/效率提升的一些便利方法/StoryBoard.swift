//
//  StoryBoard.swift
//  RXSample
//
//  Created by liangze on 2019/9/30.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

enum StoryBoard: String {
    case Main
    case DecisionTree
    case Test
}


extension NibLoadable where Self: UIViewController {
    static func fromSb(_ storyBoard: StoryBoard) -> Self {
        return fromSb(storyBoard.rawValue)
    }
}
