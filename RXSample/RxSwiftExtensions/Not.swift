//
//  ignore.swift
//  RxSwiftExt
//
//  Created by Thane Gill on 18/04/16.
//  Copyright © 2016 RxSwift Community. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == Bool {

    /// 取反
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
}
