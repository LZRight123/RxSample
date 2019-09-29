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

    let json = """
    {
        "stringType": "liangze",
        "doubleType": 30,
        "intType": 2000.11,
        "boolType": 1,
    }
    """

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let model =  TestModel(JSONString: json)
        print(model!)
        
       
        return true
    }


}


struct TestModel: AutoMappable {
    init?(map: Map) { }
    
    var stringType: String?
    var doubleType: Double?
    var intType: Int?
    var boolType: Bool?
        
}
