//
//  URLRouterItemSchemePath.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/20.
//

import Foundation

/// 精准匹配
/// scheme hostpath handler item
class URLRouterItemSchemeAndHostPath: URLRouterItem {
    var handler: URLRouterable.Type
    init(handler: URLRouterable.Type) {
        self.handler = handler
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        let can = req.url.bee.schemeHostPath == handler.bee_router
        return can
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = handler.initWith(req.url, options: req.options)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
