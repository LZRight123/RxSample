//
//  WebVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/23.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    var resource = "yqmbzsm"

    private lazy var webView = WKWebView()
        .then{
            guard let htmlPath = Bundle.main.path(forResource: resource, ofType: "html") else { return }
            
            guard let apphtml = try? String(contentsOfFile: htmlPath, encoding: .utf8) else { return }
            $0.loadHTMLString(apphtml, baseURL: Bundle.main.bundleURL)
            $0.scrollView.showsVerticalScrollIndicator = false
        }
    
    private var bridge: WKWebViewJavascriptBridge!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .random
        view.addSubview(webView)
        
        webView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(reload))
        
        WKWebViewJavascriptBridge.enableLogging()
        bridge = WKWebViewJavascriptBridge.build(for: webView)
        
        registerHandler()
    }
    
    @objc func reload(){
        webView.reloadFromOrigin()
    }
    
     private func registerHandler() {
    //        typedef void (^WVJBResponseCallback)(id responseData);
    //        typedef void (^WVJBHandler)(id data, WVJBResponseCallback responseCallback);
            bridge.registerHandler("appChangeColor") { [weak self] (data, callback) in
                self?.view.backgroundColor = .random
            }
        }

}
