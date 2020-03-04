//
//  RouterItem.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public enum URLRouterItemPriority: Int {
    case base = 1
    case schemeHostPath = 10
    case custom = 20
    case scheme = 30
}


class URLRouterItem {
    /// 优先级
    //进行从小到大的排序,小的在前面
    var priority:URLRouterItemPriority = URLRouterItemPriority.custom
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
