//
//  URLRouterItemScheme.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/20.
//

import Foundation

/// scheme handler item
class URLRouterItemScheme: URLRouterItem {
    var handler: URLRouterSchemeAble.Type
    var schemes: [String] = []
    init(_ handler: URLRouterSchemeAble.Type) {
        self.handler = handler
        schemes = handler.bee_scheme.components(separatedBy: ",")
        super.init()
        self.priority = 15
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        guard let scheme = req.url.scheme else {
            return false
        }
        return schemes.contains(scheme)
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = handler.initWith(scheme: req.url, options: req.options)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
