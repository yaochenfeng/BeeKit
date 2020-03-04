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
    var handler: URLRouterableExact.Type
    init(_ handler: URLRouterableExact.Type) {
        self.handler = handler
        super.init()
        self.priority = .schemeHostPath
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        let can = req.url.bee.schemeHostPath == handler.bee_router
        return can
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = handler.initWith(req: req)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
