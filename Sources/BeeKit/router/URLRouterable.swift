//
//  URLRouterable.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public protocol URLRouterable: NSObject {
    static func initWith(req request:URLActionRequest) -> UIViewController?
}

/// scheme://host/path
public protocol URLRouterableExact: URLRouterable {
    static var bee_router: String { get }
}
/// hostpath 
public protocol URLRouterableRegex: URLRouterable {
    static var bee_regex: String { get }
}
/// scheme://
public protocol URLRouterableScheme: URLRouterable {
    static var bee_scheme: String { get }
}
/// custom
public protocol URLRouterableCustom: URLRouterable {
    static func canHandler(_ req: URLActionRequest) -> Bool
}

public extension URLRouterableCustom where Self: NSObject {
    static var bee_priority: URLRouterPriority {
        return .custom
    }
}

public extension URLRouterableExact where Self: UIViewController {
    static var bee_router: String {
        return "beelink://nativepage/\(self)"
    }
}
