//
//  File.swift
//  
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

open class URLActionRequest {
    public private(set) var url: URL
    public var sourceController: UIViewController?
    public var options: [String: Any]?
    public var originURL: URL?
    
    public var isRedirect: Bool {
        return originURL != nil
    }
    public init(_ u: URL,
         source: UIViewController? = nil,
         params:[String:Any]? = nil) {
            url = u
            sourceController = source
            options = params
    }
    
    /// 转发
    /// - Parameter redirect: url
    public func forward(_ redirect: URL) -> Self{
        let origin = url
        url = redirect
        originURL = origin
        return self
    }
}


open class URLActionResponse {
    
    /// object for url action response
    public private(set) var obj: AnyObject?
    public private(set) var redirectURL: URL?
    
    public convenience init(obj: AnyObject?) {
        self.init()
        self.obj = obj
    }
    public convenience init(url: URL) {
        self.init()
        redirectURL = url
    }
}
