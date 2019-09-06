//
//  File.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/10/31.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

protocol AutoEquatable {}
protocol AutoDecodable: Decodable {}
protocol AutoEncodable: Encodable {}
protocol AutoCodable: AutoDecodable, AutoEncodable {}

protocol AutoCases { }
protocol AutoMappable: Mappable {}
extension AutoMappable {
    mutating func mapping(map: Map) {
        
    }
}


//MARK:- 字典转模型
protocol AutoModelToDictionary { }
extension Int { var value: Int { return self } }
extension String { var value: String { return self } }
extension Bool { var value: Bool { return self } }
extension Double { var value: Double { return self } }

//MARK: 字典转模型
protocol AutoDataToModel { }
extension Double {
    static func serialization(_ anyObj: Any?) -> Double {
        if let item = anyObj as? String, let item2 = Double(item){
            return item2
        }
        if let item = anyObj as? Double {
            return item
        }
        if let item = anyObj as? Int {
            return Double(item)
        }
        if let item = anyObj as? Bool {
            return item ? 1 : 0
        }
        return 0
    }
}
extension Int {
    static func serialization(_ anyObj: Any?) -> Int {
        if let item = anyObj as? String, let item2 = Int(item){
            return item2
        }
        if let item = anyObj as? Double {
            return Int(item)
        }
        if let item = anyObj as? Int {
            return item
        }
        if let item = anyObj as? Bool {
            return item ? 1 : 0
        }
        return 0
    }
}
extension Bool{
    static func serialization(_ anyObj: Any?) -> Bool {
        if let item = anyObj as? Bool {
            return item
        }
        if let item = anyObj as? String {
            if item == "true" {
                return true
            }
            if item == "false" {
                return false
            }
        }
        
        let v = Int.serialization(anyObj)
        if v > 0 {
            return true
        }
        return false
    }
}
extension String{
    static func serialization(_ anyObj: Any?) -> String {
        if let item = anyObj as? String{
            return item
        }
        if let item = anyObj as? Double {
            return "\(item)"
        }
        if let item = anyObj as? Int {
            return "\(item)"
        }
        if let item = anyObj as? Bool {
            return item ? "1" : "0"
        }
        return ""
    }
}

//MARK:- 以上已经实现自动生成代码
typealias AutoModelDataCodable = AutoDataToModel & AutoModelToDictionary
