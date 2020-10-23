//
//  Route.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/28.
//

import Foundation

/**
 * 路由
 */
class Route {
    /// 路由名称，可生成链接
    var name: String?
    /// scheme
    var scheme: String?
    
    var parameters: [String: String] = [:]
    /// 是否指定域名
    var host: String?
    var rootDomain: String?
    /**
     */
    var uri: String = ""
    init(_ path: String) {
        uri = path
    }
}

extension Route {
    static func match(_ path: String) -> Route {
        let route = Route(path)
        return route
    }
    func match(_ request: Request) -> Bool {
        return true
    }
}

/**
 *路由匹配路径,匹配，参数解析，
 * /user/hello
 * /user/{id: string}
 * /user/{id}
 */
class RouteUri {
    var bindingFields = [String: String]()
}
