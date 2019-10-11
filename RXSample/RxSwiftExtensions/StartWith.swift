//
//  StartWith.swift
//  RxSwiftExtensions.swift
//
//  Created by 荣恒 on 2019/7/13.
//

import RxSwift

extension ObservableType where Element == Void {
    public func startWithEmpty() -> Observable<Element> {
        return startWith(())
    }
}

extension ObservableType {
    public func startWithNil() -> Observable<Element?> {
        return map({ Optional($0) }).startWith(nil)
    }
}
