//
//  URLRouterItemRequest.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/3/4.
//

import Foundation


/// custom handle item
class URLRouterItemCustom: URLRouterItem {
    var handler: URLRouterableCustom.Type
    init(_ handler: URLRouterableCustom.Type) {
        self.handler = handler
        super.init()
        self.priority = handler.bee_priority
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        return handler.canHandler(req)
    }
    override func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = handler.initWith(req: req)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
    }
}
