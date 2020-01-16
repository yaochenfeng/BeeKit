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
    
    /// object for url action response
    private(set) var obj: AnyObject?
    convenience init(_ vc: UIViewController?) {
        self.init()
        obj = vc
    }
}
