//
//  Notification.Name+Extension.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/12/28.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let JZTOrderDetailStatusChange = Notification.Name("JZTOrderDetailStatusChange")
    static let JZTVisitRecordConfirmSuccess = Notification.Name("JZTVisitRecordConfirmSuccess")
    static let getVisitMsgUnreadCount = Notification.Name("getVisitMsgUnreadCount")
//    NSString * const AFNetworkingReachabilityDidChangeNotification = @"com.alamofire.networking.reachability.change";
    static let af_NetworkingReachabilityDidChangeNotification = Notification.Name("com.alamofire.networking.reachability.change")
}

extension Notification {
    enum JZT {
        static var login = Name("loginjzt")
    }
    
    struct JZTTest {
        static let pre = "JZTTest"
        static let login = Name(pre + "JZTTest")
    }
}
