//
//  WebViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/17.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var loadURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webview)
        var rect = view.bounds
        rect.size.height = rect.height - 100
        webview.frame = rect
        if let url = loadURL {
            webview.load(URLRequest(url: url))
        }
    }
    
    var webview =  WKWebView()

}

extension WebViewController: URLRouterSchemeAble {
    static var bee_schemeString: String = "http"
    static func initWith(_ url: URL, options: [String : Any]?) -> UIViewController? {
        let web = WebViewController()
        web.loadURL = url
        web.navigationItem.title = "scheme: \(bee_schemeString)"
        return web
    }
}

class httpsRouter: NSObject {
    
}

extension httpsRouter: URLRouterSchemeAble {
    static var bee_schemeString: String = "https"
    static func initWith(_ url: URL, options: [String : Any]?) -> UIViewController? {
        let web = WebViewController()
        web.loadURL = url
        web.navigationItem.title = "scheme: \(bee_schemeString)"
        return web
    }
}
