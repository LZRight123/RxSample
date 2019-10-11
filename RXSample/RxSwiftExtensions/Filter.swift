//
//  filter.swift
//  RHSwiftExtensions
//
//  Created by 荣恒 on 2019/4/4.
//

import Foundation
import RxSwift

// MARK: - OptionalType
public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    /// Cast `Optional<Wrapped>` to `Wrapped?`
    public var value: Wrapped? {
        return self
    }
}

public extension ObservableType where Element: OptionalType {
    /// 过滤掉为nil的元素
    func filterNil() -> Observable<Element.Wrapped> {
        return self.flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
    }
    
    func replaceNilWith(_ valueOnNil: Element.Wrapped) -> Observable<Element.Wrapped> {
        return self.map { element -> Element.Wrapped in
            guard let value = element.value else {
                return valueOnNil
            }
            return value
        }
    }
}

// MARK: - Occupiable
public protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

public extension Occupiable {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension String: Occupiable { }
extension Array: Occupiable { }
extension Dictionary: Occupiable { }
extension Set: Occupiable { }

public extension ObservableType where Element: Occupiable {
    /// 过滤掉为Empty的元素
    func filterEmpty() -> Observable<Element> {
        return self.flatMap { element -> Observable<Element> in
            guard element.isNotEmpty else {
                return Observable<Element>.empty()
            }
            return Observable<Element>.just(element)
        }
    }
}

public extension ObservableType where Element: Equatable {
    /// 留下给定的值
    func stay(_ values : Self.Element...) -> Observable<Void> {
        return filter({ values.contains($0) }).map({ _ in () })
    }
}
