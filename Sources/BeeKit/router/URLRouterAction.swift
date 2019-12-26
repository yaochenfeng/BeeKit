//
//  File.swift
//  
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

class URLActionRequest {
    private(set) var url: URL
    var sourceController: UIViewController?
    var options: [String: Any]?
    init(_ u: URL,
         source: UIViewController? = nil,
         params:[String:Any]? = nil) {
            url = u
            sourceController = source
            options = params
    }
}
class URLActionResponse {
    private(set) var viewController: UIViewController?
    convenience init(_ vc: UIViewController?) {
        self.init()
        viewController = vc
    }
}
