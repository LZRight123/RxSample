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

/// 方法交换，交换系统已有的方法
///
/// - Parameters:
///   - cls: 交换的类
///   - sels: 交换方法数组，原方法和新方法
public func swizzle<T: NSObject>(_ cls: T.Type, sels: [(Selector,Selector)]) {
    sels.forEach { original, swizzled in
        guard let originalMethod = class_getInstanceMethod(cls, original),
            let swizzledMethod = class_getInstanceMethod(cls, swizzled) else { return }
        
        let didAddViewDidLoadMethod = class_addMethod(
            cls,
            original,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddViewDidLoadMethod {
            class_replaceMethod(
                cls,
                swizzled,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}


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
