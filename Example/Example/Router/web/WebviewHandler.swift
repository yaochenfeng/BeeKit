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

extension WebviewHandler: URLRouterable {
    static func initWith(req request: URLActionRequest) -> UIViewController? {
//        if request.url.scheme?.contains("http") ?? false {
//            return WebViewController(request.url)
//        } else {
//            let newStr = request.url.absoluteString.replacingOccurrences(of: request.url.scheme ?? "", with: "https")
//            return WebViewController(newStr)
//        }
        let web = Application.shared.resolve(WebViewController.self)
        web?.loadURL = request.url
        return web
    }
}

extension WebviewHandler: URLRouterableRegex {
    static var bee_regex: String = "([A-Za-z]+).ctrip.com/"
}


//extension WebviewHandler: URLRouterableExact {
//    static var bee_router = "beelink://m.ctrip.com/webapp/vacations/tour/vacations"
//}
