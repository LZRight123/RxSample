//
//  Bind.swift
//  RxCocoaExtensions
//
//  Created by 荣恒 on 2019/4/19.
//

import RxSwift
import RxCocoa


// MARK: - 单向绑定
///单向操作符
infix operator ~> : DefaultPrecedence

// MARK: - Observable
extension ObservableType {
    
    @discardableResult
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O: ObserverType, Self.Element == O.Element {
        return observable.bind(to: observer)
    }
    
    @discardableResult
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element? == O.Element  {
        return observable.bind(to: observer)
    }
    
    @discardableResult
    public static func ~> <O>(observable: Self, observers: [O]) -> Disposable where O: ObserverType, Self.Element == O.Element {
        return observable.subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }
    
    @discardableResult
    public static func ~> <R>(observable: Self, binder: (Self) -> R) -> R {
        return observable.bind(to: binder)
    }
    
    @discardableResult
    public static func ~> (observable: Self, binder: (Self) -> Disposable) -> Disposable {
        return observable.bind(to: binder)
    }
}


// MARK: - Driver
extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    
    @discardableResult
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element == O.Element {
        return observable.drive(observer)
    }
    
    @discardableResult
    public static func ~> <O>(observable: Self, observer: O) -> Disposable where O : ObserverType, Self.Element? == O.Element  {
        return observable.drive(observer)
    }

    @discardableResult
    public static func ~> <R>(observable: Self, binder: (Observable<Self.Element>) -> R) -> R {
        return observable.drive(binder)
    }
    
    @discardableResult
    public static func ~> (observable: Self, binder: (Observable<Self.Element>) -> Disposable) -> Disposable {
        return observable.drive(binder)
    }
    
}
