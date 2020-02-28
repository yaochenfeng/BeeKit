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
