//
//  as.swift
//  RxSwiftExtensions.swift
//
//  Created by 荣恒 on 2019/7/10.
//

import RxSwift

extension ObservableType {
    /// asDriver
    public func asDriverObservable(onErrorJustReturn: Element) -> Observable<Element> {
        return observeOnMainScheduler()
            .catchErrorJustReturn(onErrorJustReturn)
            .shareOnce()
    }
    
    /// asDriver
    public func asDriverObservable(onErrorObservableWith: Observable<Element>) -> Observable<Element> {
        return observeOnMainScheduler()
            .catchError({ _ in onErrorObservableWith })
            .shareOnce()
    }
}

extension ObservableType {
    /// asSignal
    public func asSignalObservable(onErrorJustReturn: Element) -> Observable<Element> {
        return observeOnMainScheduler()
            .catchErrorJustReturn(onErrorJustReturn)
            .share()
    }
    
    /// asSignal
    public func asSignalObservable(onErrorObservableWith: Observable<Element>) -> Observable<Element> {
        return observeOnMainScheduler()
            .catchError({ _ in  onErrorObservableWith  })
            .share()
    }
}
