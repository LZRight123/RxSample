//
//  Map.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxCocoa
import RxSwift

public extension SharedSequenceConvertibleType {
    
    func mapVoid() -> SharedSequence<SharingStrategy,Void> {
        return map({ _ in () })
    }
    
    func mapTo<T>(_ value : T) -> SharedSequence<SharingStrategy,T> {
        return map({ _ in value })
    }
    
}


public extension SharedSequenceConvertibleType where Element: Collection {
    
    /// 将序列中的数组map
    func mapMany<T>(_ transform: @escaping (Element.Element) -> T) -> SharedSequence<SharingStrategy,[T]> {
        return map { collection -> [T] in
            collection.map(transform)
        }
    }
    
}
