//
//  do.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/4.
//

import Foundation
import RxSwift


// MARK: - do 副作用
public extension ObservableType {
 
    func doNext(_ next: @escaping () -> Void) -> Observable<Element> {
        return self.do(onNext: { _ in next() })
    }
    
    func doNext(_ next: @escaping (Element) -> Void) -> Observable<Element> {
        return self.do(onNext: { value in  next(value) })
    }
    
    /// 给Success添加副作用
    func doSuccess<T,E>(_ success: @escaping (T) -> Void) -> Observable<Element> where Self.Element == Result<T,E>, E : Error {
        return self.do(onNext: { result in
            switch result {
            case let .success(value): success(value)
            case .failure: break
            }
        })
    }
    
    /// 给Failure添加副作用
    func doFailure<T,E>(_ failure: @escaping (E) -> Void) -> Observable<Element> where Self.Element == Result<T,E>, E : Error {
        return self.do(onNext: { result in
            switch result {
            case .success: break
            case let .failure(error): failure(error)
            }
        })
    }
    
}
