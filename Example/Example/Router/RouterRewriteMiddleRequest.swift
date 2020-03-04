//
//  RouterRewriteMiddleRequest.swift
//  Example
//
//  Created by yaochenfeng on 2020/2/28.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import BeeKit

class RouterRewriteMiddleRequest: NSObject,URLRouterMiddleRequest {
    override init() {
        super.init()
//        self.config["beelink://nativePage/switchtab"] = "beelink://nativePage/switchtab?index=2"
//        self.config["beelink://nativePage/switchtab"] = "https://www.baidu.com"
    }
    var config:[String: String] = [String: String]()
    func processRequest(request: URLActionRequest) -> URLActionResponse? {
        guard let rewrite = config[request.url.bee.schemeHostPath] else {
            return nil
        };
        var urlComponents = URLComponents(string: rewrite)
        if let originComps = URLComponents(string: request.url.absoluteString), let originItems = originComps.queryItems {
            urlComponents?.queryItems?.append(contentsOf:originItems)
        }
        guard let url = urlComponents?.url else {
            return nil
        }
        return URLActionResponse(url: url)
    }
}
