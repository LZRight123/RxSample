//
//  File.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/11/17.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum CustomSave: String, LZUserDefaultsSettable {
        case name
        case visitRecordTip
        case shareOrderTip
    }
    
    func testusing() {
        UserDefaults.CustomSave.name.store( "hello");
        let _ = UserDefaults.CustomSave.name.storedValue
        
    }
}


public protocol LZUserDefaultsSettable {
    var uniqueKey: String { get }
}


public extension LZUserDefaultsSettable where Self: RawRepresentable {
    var uniqueKey: String {
        return "\(Self.self).\(rawValue)"
    }
    
    func store(_ value: Any?) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    
    var storedValue: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    
    func removeValue() {
        UserDefaults.standard.removeObject(forKey: uniqueKey)
    }
    
    //    public func store(_ value: Bool) {
    //        UserDefaults.standard.set(value, forKey: uniqueKey)
    //    }
    //
    //    public var storedBool: Bool {
    //        return UserDefaults.standard.bool(forKey: uniqueKey)
    //    }
    // 还有支持其他存储类型的函数，可写可不写
}


extension UserDefaults {
    struct Key<Value> {
        var name: String
    }
    
    subscript<T>(key: Key<T>) -> T? {
        get {
            return value(forKey: key.name) as? T
        }
        set {
            setValue(newValue, forKey: key.name)
        }
    }
    
    subscript<T>(key: Key<T>, default defaultProvider: @autoclosure () -> T) -> T {
        get {
            return value(forKey: key.name) as? T ?? defaultProvider()
        }
        set {
            setValue(newValue, forKey: key.name)
        }
    }
}

extension UserDefaults.Key {
    static var tests: UserDefaults.Key<[String]> {
        return .init(name: "tests")
    }
    
    static var test: UserDefaults.Key<Bool> {
        return .init(name: "test")
    }
}

/*use:
 let result =  UserDefaults.standard[.test]
  UserDefaults.standard[.test] = true
 let ruslut =  UserDefaults.standard[.test, default: false]
*/

