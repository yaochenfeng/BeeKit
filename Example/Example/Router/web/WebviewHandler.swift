//
//  WebviewRouterHandler.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class WebviewHandler: NSObject, URLRouterableScheme {
    static var bee_scheme: String = "http,https"
}
extension WebviewHandler: URLRouterableCustom {
    static func initWith(req request: URLActionRequest) -> UIViewController? {
        if request.url.scheme?.contains("http") ?? false {
            return WebViewController(request.url)
        } else {
            let newStr = request.url.absoluteString.replacingOccurrences(of: request.url.scheme ?? "", with: "https")
            return WebViewController(newStr)
        }
        
    }
    static func canHandler(_ req: URLActionRequest) -> Bool {
        if req.url.host?.contains("m.ctrip.com") ?? false {
            return true
        }
        return false
    }
    
}
