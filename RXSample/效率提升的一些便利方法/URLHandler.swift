//
//  URLHandler.swift
//  Sundell
//
//  Created by 梁泽 on 2019/8/2.
//  Copyright © 2019 梁泽. All rights reserved.
//

import Foundation
import UIKit

public typealias URLRuleHanlder = ((URL, Any?) -> Void)
public struct URLHandler {
    public static let schemes = ["gongyingshang"]
    private var currentController: UIViewController
    private let rules: [String : [URLRule]]
    
    public init(currentController: UIViewController, rules: [URLRule]) {
        self.currentController = currentController
        self.rules = Dictionary(grouping: rules) { $0.requiredHost }
    }
    
    public func handle(_ url: URL, hanlder: /*@escaping*/ URLRuleHanlder? = nil) throws {
        guard url.scheme == "gongyingshang", let host = url.host, let rules = rules[host] else {
            return
        }
        
        let input = URLRule.Input(url: url)
        
        for rule in rules {
            if rule.requiresPathComponents {
                guard !input.pathComponents.isEmpty else {
                    continue
                }
            }
            
            do {
                let vc = try rule.evaluate(input, hanlder)
                currentController.show(vc, sender: nil)
                return
            } catch URLRule.MismatchError.dont_find_vc {
                print("dont_find_vc")
            } catch URLRule.MismatchError.no_permissions(let key) {
                throw URLRule.MismatchError.no_permissions(key: key)
            } catch URLRule.MismatchError.parameter_lost(let key) {
                throw URLRule.MismatchError.parameter_lost(key: key)
            } catch {
                print("不知道什么问题")
            }
            
//            guard let vc = try? rule.evaluate(input, hanlder) else {
//                continue
//            }
//
//            currentController.show(vc, sender: nil)
//            return
        }
    }
    
    func router(_ urlString: String?, hanlder: URLRuleHanlder? = nil) throws {
        guard let urlString = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {
            return
        }
        
        try handle(url, hanlder: hanlder)
    }
}


public struct URLRule {
    /// rule所需的host，以便进行鉴定
    public var requiredHost: String
    /// URL的path Components是否必须为非空
    public var requiresPathComponents: Bool
    /// rule的主体，接受一组输入，生成视图控制器或抛出错误
    public var evaluate: (Input, URLRuleHanlder?) throws -> UIViewController
}

public extension URLRule {
    struct Input {
        var url: URL
        var pathComponents: [String]
        var queryItems: [URLQueryItem]
    }
    
    enum MismatchError: Error {
        case dont_find_vc
        case parameter_lost(key: String)
        case no_permissions(key: Error)
    }
}

public extension URLRule.Input {
    init(url: URL) {
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components.flatMap { $0.queryItems }
        
        self.init(url: url, pathComponents: pathComponents, queryItems: queryItems ?? [])
    }
    
    func valueForQueryItem(named name: String) -> String? {
        let item = queryItems.first { $0.name == name }
        return item?.value
    }
}



//MARK:- 使用
public extension URLHandler {
    static let firstModal: [URLRule] = [.first, .search(using: "haha")]
}

public extension URLRule {
    static var first: URLRule {
        return URLRule(requiredHost: "activity", requiresPathComponents: true, evaluate: { (input, _) -> UIViewController in
            let vc_name = input.pathComponents[0]
            switch vc_name{
            case "":
                break
            default:
                throw MismatchError.dont_find_vc
            }
            return UIViewController()
        })
    }
    

    
    static func search(using loader: String) -> URLRule {
        return URLRule(requiredHost: "search", requiresPathComponents: false, evaluate: { (input, _) -> UIViewController in
            print(input)
            return UIViewController()
        })
    }
}
