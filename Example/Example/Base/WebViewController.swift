//
//  WebViewController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import WebKit

protocol ServiceProvider: class {
    init(app: ApplicationContract)
    var app: ApplicationContract { get }
    
    /// 注册服务
    func register()
    /// 启动
    func boot()
}


class WebServceProvider: ServiceProvider {
    required init(app: ApplicationContract) {
        self.app = app
    }
    
    var app: ApplicationContract
    
    func register() {
        
    }
    
    func boot() {
        
    }
    
}

class WebViewController: UIViewController {
    var loadURL: URL?
    var webview: WKWebView = {
        let config = WKWebViewConfiguration()
        let web = WKWebView(frame: .zero, configuration: config)
        return web
    }()
    convenience init(_ url: URL?) {
        self.init()
        loadURL = url
    }
    convenience init(_ str: String?) {
        self.init(str?.bee.encodeURL)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webview)
        webview.frame = view.bounds
        if let url = loadURL {
            webview.load(URLRequest(url: url))
        }
    }
}
