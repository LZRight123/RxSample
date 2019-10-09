//
//  Disposed+Operator.swift
//  RxCocoaExtensions.swift
//
//  Created by 荣恒 on 2019/5/20.
//

import RxSwift


precedencegroup DisposePrecedence {
    associativity: left
    
    lowerThan: DefaultPrecedence
}

infix operator ~ : DisposePrecedence

extension DisposeBag {
    
    public static func ~ (disposable: Disposable, disposeBag: DisposeBag) {
        disposable.disposed(by: disposeBag)
    }
    
    public static func ~ (disposables: [Disposable], disposeBag: DisposeBag) {
        disposeBag.insert(disposables)
    }
    
}
