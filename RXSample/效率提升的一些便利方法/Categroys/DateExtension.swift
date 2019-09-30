//
//  DateExtension.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2019/2/19.
//  Copyright © 2019 com.FBBC.JoinTown. All rights reserved.
//

import Foundation
//MARK:- 通用
extension Calendar {
    static let shareCalendar = Calendar.current
}


extension Date {
    static func dateWith(_ dateString: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            return Date(timeIntervalSince1970: 0)
        }
    }
    
    //本月开始日期
    func startOfCurrentMonth() -> Date {
        let calendar = Calendar.shareCalendar
        let components = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    //本月结束日期
    func endOfCurrentMonth(returnEndTime:Bool = true) -> Date {
        let calendar = Calendar.shareCalendar
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
    
    //格式化 "yyyy-MM-dd HH:mm:ss"
    func formatter(_ format: String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    func addYears(_ years: Int) -> Date {
        let calendar = Calendar.shareCalendar
        var components = DateComponents()
        components.year = years
        return calendar.date(byAdding: components, to: self)!
    }
    
    func addMonths(_ months: Int) -> Date {
        let calendar = Calendar.shareCalendar
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: self)!
    }
    
    func addWeeks(_ week: Int) -> Date {
        let calendar = Calendar.shareCalendar
        var components = DateComponents()
        components.weekOfYear = week
        return calendar.date(byAdding: components, to: self)!
    }
    
    func addDays(_ days: Int) -> Date {
        let aTimeInterval = timeIntervalSinceReferenceDate + 86400 * days.toDouble
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate;
    }
}

//MARK:- 年月日 时分秒
extension Date{
    var year: Int {
        return Calendar.shareCalendar.component( .year, from: self)
    }
    
    var month: Int {
        return Calendar.shareCalendar.component( .month, from: self)
    }
    
    var day: Int {
        return Calendar.shareCalendar.component( .day, from: self)
    }
    
    var hour: Int {
        return Calendar.shareCalendar.component( .hour, from: self)
    }
    
    var minute: Int {
        return Calendar.shareCalendar.component( .minute, from: self)
    }
    
    var second: Int {
        return Calendar.shareCalendar.component( .second, from: self)
    }
}
