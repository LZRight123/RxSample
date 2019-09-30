//
//  OptionalExtension .swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/12/21.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Optional {
    func matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self else {
            return nil
        }
        
        guard predicate(value) else {
            return nil
        }
        
        return value
    }
}

extension Optional where Wrapped == UIView {
    mutating func get<T: UIView>(
        orSet expression: @autoclosure () -> T
        ) -> T {
        guard let view = self as? T else {
            let newView = expression()
            self = newView
            return newView
        }
        
        return view
    }
}
