//
//  WebViewController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import WebKit

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
