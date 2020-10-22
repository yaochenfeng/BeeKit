//
//  WebViewController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift
import BeeKit

class WebViewController: UIViewController, BeanContract {
    let disposeBag = DisposeBag()
    var loadURL: URL?
    var webview: WKWebView = {
        let config = WKWebViewConfiguration()
        let web = WKWebView(frame: .zero, configuration: config)
        return web
    }()
    convenience init(_ url: URL?) {
        self.init(context: Application.shared)
        loadURL = url
    }
    convenience init(_ str: String?) {
        self.init(str?.bee.encodeURL)
    }
    required init(context: ContainerContract) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webview)
        webview.frame = view.bounds
        if let url = loadURL {
            webview.load(URLRequest(url: url))
        }
        webview.rx.observeWeakly(String.self, "title").bind(to: navigationItem.rx.title).disposed(by: disposeBag)
    }
}
