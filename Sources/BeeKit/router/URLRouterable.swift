//
//  URLRouterable.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public protocol URLRouterable: NSObject {
    static var bee_router: String { get }
    static func initWith(_ url: URL, options:[String:Any]?) ->UIViewController?
}

public protocol URLRouterSchemeAble: NSObject {
    static var bee_scheme: String { get }
    static func initWith(scheme url: URL, options:[String:Any]?) ->UIViewController?
}

public extension URLRouterable where Self: UIViewController {
    static var bee_router: String {
        return "beelink://nativePage/\(self)"
    }
    static func initWithRouter(_ url: URL, options:[String:Any]?) ->UIViewController? {
        let rvc = self.init(nibName: nil, bundle: Bundle(for: self.classForCoder()))
        return rvc
    }
}
