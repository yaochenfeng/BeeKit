//
//  RouterItem.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

class URLRouterItem {
    /// 优先级
    //进行从小到大的排序,小的在前面
    var priority = 5
    func handler(_ req: URLActionRequest) -> URLActionResponse {
        return URLActionResponse()
    }
    func canHandler(_ req: URLActionRequest) -> Bool {
        return false
    }
}

extension URLRouterItem: Equatable {
    static func == (lhs: URLRouterItem, rhs: URLRouterItem) -> Bool {
        return lhs === rhs      //表示两个类类型（class type）的常量或者变量引用同一个类实例
    }
}

/// 精准匹配
class URLRouterItemPage: URLRouterItem {
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
