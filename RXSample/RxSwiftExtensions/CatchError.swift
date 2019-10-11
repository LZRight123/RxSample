//
//  CatchError.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/4.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift

public extension ObservableType {
    
    func catchErrorJustReturn(closure: @escaping @autoclosure () throws -> Element) -> Observable<E> {
        return catchError { _ in
            return Observable.just(try closure())
        }
    }
    
    /// 替换错误事件为 Complete
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            Observable.empty()
        }
    }
}
