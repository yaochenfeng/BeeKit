//
//  WebviewRouterHandler.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class WebviewHandler: NSObject, URLRouterSchemeAble {
    static var bee_scheme: String = "http,https"
    
    static func initWith(scheme url: URL, options: [String : Any]?) -> UIViewController? {
        return WebViewController(url)
    }
}
