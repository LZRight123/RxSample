//
//  ControlProperty.swift
//  Alamofire
//
//  Created by 荣恒 on 2019/4/25.
//

import RxSwift
import RxCocoa

extension ControlPropertyType {
    
    /// 转换来源
    public func mapSource(_ transfrom: @escaping (Self.Element) -> Element) -> ControlProperty<Self.E> {
        return ControlProperty(values: self.asObservable().map(transfrom), valueSink: self)
    }
    
}
