//
//  WebVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/23.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

class WebVC: UIViewController {
    
    var resource: String!
    
    fileprivate let disposeBag = DisposeBag()

    private lazy var contetView = UIView(color: .white)
        .then{
            $0.cornerRadius = 16
            $0.masksToBounds = true
    }
    
    private lazy var wkConfig = WKWebViewConfiguration()
        .then{
            let userContent = WKUserContentController()
            let userInfo = ["name": "wb", "sex": "male", "phone": "12333434"]
            for key in userInfo.keys {
                let script = WKUserScript(source: "var \(key) = \"\(userInfo[key]!)\"", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
                userContent.addUserScript(script)
            }
            $0.userContentController = userContent

        }
    
    private lazy var webView = WKWebView()
        .then{
            
            guard let htmlPath = Bundle.main.path(forResource: resource, ofType: "html") else {
                assert(false, "resource is nil")
                return
            }
            
            guard let apphtml = try? String(contentsOfFile: htmlPath, encoding: .utf8) else { return }
            
            $0.cornerRadius = 14
            $0.masksToBounds = true
            $0.loadHTMLString(apphtml, baseURL: Bundle.main.bundleURL)
            $0.scrollView.bounces = false
            $0.scrollView.showsVerticalScrollIndicator = false
    }
    
    
    private var bridge: WKWebViewJavascriptBridge!
    
    static func build(_ resource: String) -> WebVC {
        let vc = WebVC()
        vc.resource = resource
        vc.setupTransitioningAnimate(AnimatorOC.popup)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(71)
            $0.height.equalTo(min(594, ScreenHeight - 71 * 2))
            $0.left.equalToSuperview().offset(47)
            $0.right.equalToSuperview().offset(-47)
        }
    
        
   
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(reload))
        
        WKWebViewJavascriptBridge.enableLogging()
        bridge = WKWebViewJavascriptBridge(for: webView)
        registerHandler()
    }
    
    @objc func reload(){
        webView.reloadFromOrigin()
    }
    
    private func registerHandler() {
        //        typedef void (^WVJBResponseCallback)(id responseData);
        //        typedef void (^WVJBHandler)(id data, WVJBResponseCallback responseCallback);
        bridge.registerHandler("appChangeColor") { [weak self] (data, callback) in
            print("call me")
            self?.view.backgroundColor = .random
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
}
