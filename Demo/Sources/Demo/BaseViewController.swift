//
//  BaseViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/2.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit
import BeeKit

class BaseViewController: UIViewController {
    class func initWithRouter(_ url: URL, options: [String : Any]?) -> BaseViewController? {
        return self.init()
    }
    class var canAutoLoad: Bool {
        return false
    }
    
}

extension BaseViewController: URLRouterable {
    static func initWith(_ url: URL, options: [String : Any]?) -> UIViewController? {
        let rvc = self.initWithRouter(url, options: options)
        for item in  (URLComponents(string: url.absoluteString)?.queryItems ?? []) where item.name == "title" {
            rvc?.navigationItem.title = "title: \(item.value ?? "")"
        }
        return rvc
    }
}
