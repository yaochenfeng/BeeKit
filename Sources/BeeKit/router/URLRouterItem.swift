//
//  RouterItem.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public enum URLRouterPriority: Int {
    case base = 1
    case schemeHostPath = 10
    case custom = 20
    case scheme = 30
}


class URLRouterItem {
    var handler: URLRouterable.Type
    init(_ handler: URLRouterable.Type) {
        self.handler = handler
    }
    /// 优先级
    //进行从小到大的排序,小的在前面
    var priority:URLRouterPriority = .custom
    func handler(_ req: URLActionRequest) -> URLActionResponse {
        guard let nvc = handler.initWith(req: req)  else {
            return URLActionResponse()
        }
        return URLActionResponse(nvc)
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
/// scheme hostpath handler item
class URLRouterItemSchemeAndHostPath: URLRouterItem {
    var bee_router:String
    init(_ handler: URLRouterable.Type, router:String) {
        self.bee_router = router
        super.init(handler)
        self.priority = .schemeHostPath
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        let can = req.url.bee.schemeHostPath == self.bee_router
        return can
    }
}


/// scheme handler
class URLRouterItemScheme: URLRouterItem {
    
    var schemes: [String] = []
    init(_ handler: URLRouterable.Type, schemes:[String]) {
        self.schemes = schemes
        super.init(handler)
        self.priority = .scheme
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        guard let scheme = req.url.scheme else {
            return false
        }
        return schemes.contains(scheme)
    }
}


/// custom handle item
class URLRouterItemCustom: URLRouterItem {
    var routerItem: URLRouterableCustom.Type
    init(_ handler: URLRouterableCustom.Type) {
        self.routerItem = handler
        super.init(handler)
        self.priority = .custom
    }
    override func canHandler(_ req: URLActionRequest) -> Bool {
        return routerItem.canHandler(req)
    }
}
