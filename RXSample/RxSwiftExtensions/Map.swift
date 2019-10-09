//
//  map.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/4.
//

import Foundation
import RxSwift


public extension ObservableType {
    
    func mapVoid() -> Observable<Void> {
        return map({ _ in () })
    }
    
    func mapValue<T>(_ value : T) -> Observable<T> {
        return map({ _ in value })
    }
    
    /// map 成功后的值
    func mapSuccess<T,E>() -> Observable<T> where Self.Element == Result<T,E>, E : Error {
        return map({ try? $0.get() }).filterNil()
    }
    
    /// map 失败后的值
    func mapFailure<T,E>() -> Observable<E> where Self.Element == Swift.Result<T,E>, E : Error {
        return map({ result -> E? in
            switch result {
            case .success: return nil
            case let .failure(failure): return failure
            }
        })
            .filterNil()
    }
    
}

// MARK: - 序列 Collection Map
public extension ObservableType where Element: Collection {
    
    /// 将序列中的数组map
    func mapMany<T>(_ transform: @escaping (Self.Element.Element) -> T) -> Observable<[T]> {
        return self.map { collection -> [T] in
            collection.map(transform)
        }
    }
    
}
