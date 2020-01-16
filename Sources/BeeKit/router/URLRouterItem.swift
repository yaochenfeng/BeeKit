//
//  RouterItem.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

class URLRouterItem {
    func handler(_ req: URLActionRequest) -> URLActionResponse {
        return URLActionResponse()
    }
    func canHandler(_ req: URLActionRequest) -> Bool {
        return false
    }
}

class URLRouterItemPage: URLRouterItem {
    var pageRouter: URLRouterable.Type
    init(handler: URLRouterable.Type) {
        self.pageRouter = handler
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        let can = req.url.bee.schemeHostPath == pageRouter.bee_routeString
        return can
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = pageRouter.initWith(req.url, options: req.options)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
