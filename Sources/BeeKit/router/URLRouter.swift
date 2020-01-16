//
//  URLRouter.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public final class URLRouter {
    public static let shared: URLRouter = {
        let shared = URLRouter()
        // 可以做一些其他的配置
        return shared
    }()
    /// 路由项
    private var routerItems = [URLRouterItem]()
    
    public var openHandler: ((_ source:UIViewController, _ dest:UIViewController, _ options: [String:Any]?) -> Void)?
    
    private init(){
        autoLoadRouter()
    }
    /// 是否能处理路由
    /// - Parameters:
    ///   - url: router url
    ///   - source: 从哪个页面收到的路由
    ///   - options: 额外参数
    public func canOpen(with url:URL?,
                 source: UIViewController? = nil,
                 options:[String:Any]? = nil) -> Bool {
        guard let reqURL = url else {
            return false
        }
        let req = URLActionRequest(reqURL,source: source, params: options)
        for item in routerItems where item.canHandler(req) {
            return true
        }
        return false
    }
    
    public func open(_ url: URL?,
              source: UIViewController? = nil,
              options:[String:Any]? = nil) {
        guard let reqURL = url else {
            return
        }
        let req = URLActionRequest(reqURL,source: source, params: options)
        var response: URLActionResponse?
        for item in routerItems where item.canHandler(req) {
            response = item.handler(req)
            break
        }
        guard let dest = response?.obj as? UIViewController, let sourceVC = source else {
            return
        }
        guard let handler = openHandler else {
            sourceVC.show(dest, sender: nil)
            return
        }
        handler(sourceVC,dest, options)
    }
}

extension URLRouter {
    /// 自动加注册所有路由
   fileprivate func autoLoadRouter() {
        var count: UInt32 = 0
        guard let classList = objc_copyClassList(&count) else {
            return
        }
        for index in 0..<numericCast(count) {
            let cls: AnyClass = classList[index]
            if let pro = cls as? URLRouterable.Type {
                routerItems.append(URLRouterItemPage(handler: pro))
            }
            
        }
    }
}

