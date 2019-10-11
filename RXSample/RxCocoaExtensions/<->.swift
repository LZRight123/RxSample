 //
//  Operators.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - 双向绑定

/// 双向绑定操作符
infix operator <-> : DefaultPrecedence

@discardableResult
public func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}


/// 通用序列双向绑定
@discardableResult
public func <-> <T,S : ObservableType & ObserverType>(property: ControlProperty<T>, subject: S) -> Disposable where S.Element == T  {
    
    let bindToUIDisposable = subject.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            subject.onNext(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToRelay)
}
 

