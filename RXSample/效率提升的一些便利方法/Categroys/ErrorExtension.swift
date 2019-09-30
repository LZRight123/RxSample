//
//  ErrorExtension.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2019/2/28.
//  Copyright © 2019 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

//MARK:- urlerror
extension Error {
    var urlCannotConnect: Bool {
        switch self {
        case URLError.notConnectedToInternet, URLError.networkConnectionLost, URLError.cannotConnectToHost, URLError.cannotLoadFromNetwork:
            return true
        default:
            return false
        }
    }
}
