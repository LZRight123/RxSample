//
//  ArrayExtension.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2019/4/22.
//  Copyright © 2019 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

extension Array {
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
