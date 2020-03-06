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
        /// 自动加注册所有路由
        shared.autoLoadRouter()
        // 可以做一些其他的配置
        return shared
    }()
    
    /// 路由项
    private var routerItems = [URLRouterItem]()
    private var requestMiddlewares = [URLRouterMiddleRequest]()
    private var responseMiddlewares = [URLRouterMiddleResponse]()
    /// 处理显示UIViewController
    /// - Parameters:
    ///   - source: 从哪个页面来
    ///   - dest: 目标页面
    ///   - options: 额外参数
    public var openHandler: ((_ source:UIViewController, _ dest:UIViewController, _ options: [String:Any]?) -> Void)?
    
    private init(){}
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
            registerRouter(cls)
        }
        sortRouters()
    }
    
    /// 路由排序
    public func sortRouters() {
        routerItems = routerItems.sorted(by: { (item1, item2) -> Bool in
            //优先级进行从小到大的排序
            return item2.priority.rawValue > item1.priority.rawValue
        })
    }
    public func add(_ mid: URLRouterMiddleRequest){
        requestMiddlewares.append(mid)
    }
    public func add(_ mid: URLRouterMiddleResponse){
        responseMiddlewares.append(mid)
    }
    public func registerRouter(_ cls: AnyClass){
        if let pro = cls as? URLRouterableExact.Type {
            routerItems.append(URLRouterItemSchemeAndHostPath(pro, router: pro.bee_router))
        }
        if let pro = cls as? URLRouterableRegex.Type {
            routerItems.append(URLRouterItemHostPathRegex(pro, pattern: pro.bee_regex))
        }
        if let pro = cls as? URLRouterableScheme.Type {
            routerItems.append(URLRouterItemScheme(pro, schemes: pro.bee_scheme.components(separatedBy: ",")))
        }
        if let pro = cls as? URLRouterableCustom.Type {
            routerItems.append(URLRouterItemCustom(pro))
        }
    }
}

extension URLRouter {
    
    /// get obj for url
    /// - Parameters:
    ///   - type: obj.Type
    ///   - url: url
    ///   - source: which controller from
    ///   - options: options
    public func objectFor<T>(type: T.Type,
                             url: URL?,
                             source: UIViewController? = nil,
                             options:[String:Any]? = nil) -> T? {
        guard let reqURL = url else {
            return nil
        }
        let req = URLActionRequest(reqURL,source: source, params: options)
        let response = process(req)
        guard let obj = response?.obj as? T else {
            return nil
        }
        return obj
    }
    
    private func process(_ req:URLActionRequest) -> URLActionResponse? {
        // 处理前置路由中间件
        var response = preprocess(req)
        // 处理转发路由
        let rewrite = response?.redirectURL
        if req.isRedirect, let _ = response?.redirectURL {
            response = nil
        } else if let rewriteURL = rewrite {
            return process(req.forward(rewriteURL))
        }
        
        if response == nil {
            for item in routerItems where item.canHandler(req) {
                response = item.handler(req)
                break
            }
        }
        // 处理结果路由中间件
        for mid in responseMiddlewares {
            response = mid.processResponse(response: response, request: req)
        }
        return response
    }
    private func preprocess(_ req:URLActionRequest) -> URLActionResponse? {
        for mid in requestMiddlewares {
            guard let response = mid.processRequest(request: req) else {
                return nil
            }
            return response
        }
        return nil
    }
    
}

extension URLRouter {
    /// 是否能处理路由
    /// - Parameters:
    ///   - url: router url
    ///   - source: 从哪个页面收到的路由
    ///   - options: 额外参数
    public func canOpen(with url:URL?,
                        source: UIViewController? = UIViewController.bee.topVisibleViewController(),
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
                     source: UIViewController? = UIViewController.bee.topVisibleViewController(),
                     options:[String:Any]? = nil) {
        guard let dest = self.objectFor(type: UIViewController.self, url: url,source: source, options: options),
            let sourceVC = source else {
                return
        }
        guard let handler = openHandler else {
            sourceVC.show(dest, sender: nil)
            return
        }
        handler(sourceVC,dest, options)
    }
}
