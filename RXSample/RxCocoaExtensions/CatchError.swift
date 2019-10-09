//
//  CatchError.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxCocoa
import RxSwift

public extension ObservableConvertibleType {
    
    func asDriver(onErrorJustReturnClosure: @escaping @autoclosure () -> Element) -> Driver<Element> {
        return asDriver { _ in
            Driver.just(onErrorJustReturnClosure())
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}
