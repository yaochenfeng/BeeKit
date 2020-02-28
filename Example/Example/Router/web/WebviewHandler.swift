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
    
    static func initWith(scheme request: URLActionRequest) -> UIViewController? {
        return WebViewController(request.url)
    }
}
