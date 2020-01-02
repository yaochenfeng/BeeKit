//
//  RouterItem.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import Foundation

class URLRouterItem {
    func handler(_ req: URLActionRequest) -> URLActionResponse {
        return URLActionResponse()
    }
    func canHandler(_ req: URLActionRequest) -> Bool {
        return false
    }
    func schemeHostPath(_ url: URL) -> String {
        return "\(url.scheme ?? "http")://\(url.host ?? "")\(url.path)"
    }
}

class URLRouterItemPage: URLRouterItem {
    var pageRouter: URLRouterable.Type
    init(handler: URLRouterable.Type) {
        self.pageRouter = handler
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        return schemeHostPath(req.url) == pageRouter.bee_routeString
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = pageRouter.initWith(req.url, options: req.options)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
