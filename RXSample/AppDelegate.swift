//
//  AppDelegate.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
@_exported import RxSwift
@_exported import RxCocoa
@_exported import SnapKit
@_exported import Moya
@_exported import Alamofire
@_exported import MBProgressHUD
@_exported import MJRefresh
@_exported import ObjectMapper


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let one = UILabel()
        let two = one
        print("%x", one)
        print("%x", &two)

        return true
    }


}

