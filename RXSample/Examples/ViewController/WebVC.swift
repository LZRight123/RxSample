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
    enum ResourceType {
        case html
        case fileUrl
        case remtoURL
    }
    
    var resource: String!
    var resourceType: ResourceType!
    
    fileprivate let disposeBag = DisposeBag()
    
    private lazy var contetView = UIView(color: .white)
        .then{
            $0.cornerRadius = 16
            $0.masksToBounds = true
    }
    
    private lazy var wkConfig = WKWebViewConfiguration()
        .then{
            // 注入js变量 对像 通过  WKUserContentController addUserScript  ,注入到window.$ 全局变量
            let userContent = WKUserContentController()
            let keyValue = [
                "key1": "value1",
                "key2": "value2",
                "key3": "value3"
            ]
            
            //MARK: - 注入js
            //注入变量
            for (key, value) in keyValue {
                let script = WKUserScript(source: "var \(key) = \"\(value)\"", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
                userContent.addUserScript(script)
            }
            
            let userInfo = [
                "name": "梁泽",
                "sex": "男",
                "phone": "15271327766"
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
            let jsonText = String.init(data: jsonData!, encoding: String.Encoding.utf8)!
            
            //注入对像
            var script = WKUserScript.init(source: "var userInfo = \(jsonText)", injectionTime: .atDocumentStart, forMainFrameOnly: true)
            userContent.addUserScript(script)
            
            //注入函数
            script = WKUserScript.init(source: "var iOSApp = {\"getUserInfo\":function(){return \(jsonText)}}", injectionTime: .atDocumentStart, forMainFrameOnly: true)
            userContent.addUserScript(script)
            
            
            let function1 = """
            function getUserInfo(){
            return \(String(describing: jsonText))
            }
            """
            script = WKUserScript(source: function1, injectionTime: .atDocumentStart, forMainFrameOnly: true)
            userContent.addUserScript(script)
            //也可以在 didFinish 通过 evaluateJavaScript 注入
            
            
            //MARK: - H5传递信息给Native，调用Native
            userContent.add(self, name: "changeIDColor")
            userContent.add(self, name: "closeCurrentVC")
            
            
            $0.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
            $0.preferences.javaScriptCanOpenWindowsAutomatically = true
            $0.preferences.javaScriptEnabled = true
            $0.userContentController = userContent
    }
    
    private lazy var webView = WKWebView(frame: .zero, configuration: wkConfig)
        .then{
            
            $0.cornerRadius = 14
            $0.masksToBounds = true
//            $0.scrollView.bounces = false
            $0.scrollView.showsVerticalScrollIndicator = false
            $0.backgroundColor = .random
    }
    
    private let textLabel = UILabel(font: .font13, textColor: .main, text: "", numberOfLines: 0).then{ $0.backgroundColor = .black }
    
    
    private var bridge: WKWebViewJavascriptBridge!
    
    static func build(_ resource: String, resourceType: ResourceType = .html) -> WebVC {
        let vc = WebVC()
        vc.resource = resource
        vc.resourceType = resourceType
        vc.setupTransitioningAnimate(AnimatorOC.popup)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        view.addSubviews(webView, textLabel)
        webView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(71)
            $0.height.equalTo(500)
            $0.left.equalToSuperview().offset(47)
            $0.right.equalToSuperview().offset(-47)
        }
        
        textLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.webView.snp.bottom).offset(5)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(reload))
        
        
        loadPage()
        
    }
    
    
    private func loadPage() {
        switch resourceType {
        case .html:
            guard let htmlPath = Bundle.main.path(forResource: resource, ofType: "html") else {
                assert(false, "resource is nil")
                return
            }
            
            guard let apphtml = try? String(contentsOfFile: htmlPath, encoding: .utf8) else { return }
            
            
            webView.loadHTMLString(apphtml, baseURL: Bundle.main.bundleURL)
        case .fileUrl:
            let url = Bundle.main.url(forResource: resource, withExtension: "html")!
            webView.loadFileURL(url, allowingReadAccessTo: Bundle.main.bundleURL)
        case .remtoURL:
            webView.load(URLRequest(url: URL(string: resource)!))
        default:
            break
        }
        
        
    }
    
    @objc private func reload(){
        webView.reloadFromOrigin()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("webVC 释放了")
    }
}


//MARK: - WKNavigationDelegate
extension WebVC: WKNavigationDelegate {
    //代理方法加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let userInfo = [
            "name": "梁泽",
            "sex": "男",
            "phone": "15271327766"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        let jsonText = String.init(data: jsonData!, encoding: String.Encoding.utf8)!
        
        webView.evaluateJavaScript("var iOSAppDidFinish = {\"getUserInfo\":function(){return \(jsonText)}}", completionHandler: nil)
    }
    
}

//MARK: - WKUIDelegate 与JS交互时的ui展示相关，比如JS的alert、confirm、prompt
extension WebVC: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("111111")
        return nil
    }
    
    func webViewDidClose(_ webView: WKWebView){
        print(#function)
    }
    
    
    //    JS的alert()方法时，就会回调此API。
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // We must call back js
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void){
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // 点击完成后，可以做相应处理，最后再回调js端
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) -> Void in
            // 点击取消后，可以做相应处理，最后再回调js端
            completionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.textColor = .random
            
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // 处理好之前，将值传到js端
            completionHandler(alert.textFields![0].text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}




//MARK: - WKScriptMessageHandler 与js交互相关，通常是ios端注入名称，js端通过window.webkit.messageHandlers.{NAME}.postMessage()来发消息到ios端
extension WebVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        print(message.body)
        print(message.name)
        print(message.frameInfo.request)
        
        
        if message.name == "closeCurrentVC" {
            
            dismiss(animated: true, completion: nil)
            return
        }
        
        
        
        guard message.name == "changeIDColor" else { return }
        
        
        var text = "funtcion name: " + message.name + "\n"
        guard let dic = message.body as? [String: Any] else  { return }
        for (k, v) in dic {
            text += k + " : " + "\(v)" + "\n"
        }
        
        let handlerName = dic["handlerName"]!
//        let scripte = "\(handlerName)(\("第一个参数"), \(2), \(3.3))"
        let userInfo = [
                      "name": "梁泽",
                      "sex": "男",
                      "phone": "15271327766",
                      "number": 123
            ] as [String : Any]
        let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        let jsonText = String(data: jsonData!, encoding: String.Encoding.utf8)!
        let scripte = """
        \(handlerName)(\(1), \(2) , \(jsonText))
        """
        
        message.webView?.evaluateJavaScript(scripte, completionHandler: { (d, e) in
            print(d)
            print(e)
        })
        
        textLabel.text = text
        textLabel.backgroundColor = .random
        textLabel.textColor = .random
    }
}
