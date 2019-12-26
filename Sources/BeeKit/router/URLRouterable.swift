//
//  URLRouterable.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public protocol AutoConfigable {}

public protocol URLRouterable: AutoConfigable {
    static var bee_routeString: String { get }
    static func initWith(_ url: URL, options:[String:Any]?) ->UIViewController?
}

public extension URLRouterable where Self: UIViewController {
    static var bee_routeString: String {
        return "bee://nativePage/\(self)"
    }
    static func initWith(_ url: URL, options:[String:Any]?) ->UIViewController? {
        let rvc = self.init(nibName: nil, bundle: Bundle(for: self.classForCoder()))
        return rvc
    }
}
