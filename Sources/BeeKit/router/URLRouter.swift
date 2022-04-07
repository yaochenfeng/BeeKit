//
//  URLRouter.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import UIKit

public final class URLRouter {
    /// 是否自动注册路由
    public static var isAutoLoadRouter = true
    ///是否自动缓存
    public static var isAutoCacheRouter = false
    public static let shared: URLRouter = {
        let shared = URLRouter()
        guard isAutoLoadRouter else {
            return shared
        }
        /// 自动加注册所有路由
        Bee.messure("autoLoadRouter") {
            shared.autoLoadRouter()
        }
        shared.sortRouters()
        // 可以做一些其他的配置
        return shared
    }()
    private var clsModules = [AnyClass]()
    /// 路由项
    private var routerItems = [URLRouterItem]()
    private var requestMiddlewares = [URLRouterMiddleRequest]()
    private var responseMiddlewares = [URLRouterMiddleResponse]()
    /// 自定义处理显示UIViewController逻辑
    /// - Parameters:
    ///   - source: 从哪个页面来
    ///   - dest: 目标页面
    ///   - options: 额外参数
    public var openHandler: ((_ source:UIViewController, _ dest:UIViewController, _ options: [String:Any]?) -> Void)?
    @FileCacheStorage("\(BeeContant.version)routerClassName", defaultValue: [])
    fileprivate var routerClassNameList: [String]
    private init(){}
}

extension URLRouter {
    public func add(_ mid: URLRouterMiddleRequest){
        requestMiddlewares.append(mid)
    }
    public func add(_ mid: URLRouterMiddleResponse){
        responseMiddlewares.append(mid)
    }
    public func register(exact: String, handler: URLRouterable.Type){
        routerItems.append(URLRouterItemSchemeAndHostPath(handler, router: exact))
    }
    public func register(regex: String, handler: URLRouterable.Type){
        routerItems.append(URLRouterItemHostPathRegex(handler, pattern: regex))
    }
    public func register(scheme: String, handler: URLRouterable.Type){
        routerItems.append(URLRouterItemScheme(handler, scheme: scheme))
    }
    public func register(custom: URLRouterableCustom.Type){
        routerItems.append(URLRouterItemCustom(custom))
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
                             options:[String:Any]? = nil,
                             source: UIViewController? = nil) -> T? {
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
            if let response = mid.processRequest(request: req) {
                return response
            }
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
                        options:[String:Any]? = nil,
                        source: UIViewController? = UIViewController.bee.topVisible()) -> Bool {
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
                     options:[String:Any]? = nil,
                     source: UIViewController? = UIViewController.bee.topVisible()) {
        guard let dest = self.objectFor(type: UIViewController.self, url: url,options: options, source: source),
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


extension URLRouter {
    /// 路由排序
    public func sortRouters() {
        routerItems = routerItems.sorted(by: { (item1, item2) -> Bool in
            //优先级进行从小到大的排序
            return item2.priority.rawValue > item1.priority.rawValue
        })
    }
    
    /// 注册路由
    /// - Returns: 实现了路由的类名
    public func registerRouter(_ cls: AnyClass) -> String? {
        // 实现了路由协议
        let clsStr = NSStringFromClass(cls)
        guard clsStr.contains("."), !clsStr.contains("NSZombie"), let _ = cls as? URLRouterable.Type else {
            return nil
        }
        if let pro = cls as? URLRouterableExact.Type {
            routerItems.append(URLRouterItemSchemeAndHostPath(pro, router: pro.bee_router))
            register(exact: pro.bee_router, handler: pro)
        }
        if let pro = cls as? URLRouterableRegex.Type {
            register(regex: pro.bee_regex, handler: pro)
        }
        if let pro = cls as? URLRouterableScheme.Type {
            let schemes = pro.bee_scheme.components(separatedBy: ",")
            for scheme in schemes {
                register(scheme: scheme, handler: pro)
            }
        }
        if let pro = cls as? URLRouterableCustom.Type {
            register(custom: pro)
        }
        return clsStr
    }
    /// 自动加注册所有路由,自动加载路由每个版本会缓存路由类,加速处理
    fileprivate func autoLoadRouter() {
        // 加载此版本缓存
        if URLRouter.isAutoCacheRouter {
            let classList = routerClassNameList
            for clsStr in classList {/// register  only swift class for URLRouter
                if let cls = NSClassFromString(clsStr) {
                    _ = registerRouter(cls)
                }
            }
            if classList.count > 0 {return}
        }
        Bundle.allFrameworks.forEach { bd in
            if bd == .main {//主工程
                addModule(bd.principalClass)
            } else if let _ = bd.infoDictionary?["AUTOLOAD"] {
                addModule(bd.principalClass)
            }
        }
    }
    fileprivate func addModule(_ principal: AnyClass?) {
        guard let cls = principal, !clsModules.contains(where: { exit in
            ObjectIdentifier(exit) == ObjectIdentifier(cls)
        }), let imgName = class_getImageName(cls) else {
            return
        }
        clsModules.append(cls)
        var counts: UInt32 = 0
        guard let classNames = objc_copyClassNamesForImage(imgName, &counts) else {
            return
        }
        var classNameList = [String]()
        for i in 0 ..< Int(counts) {
            if let clsName = String(cString: classNames[i], encoding: .utf8),
               let cls: AnyClass = NSClassFromString(clsName)  {
                if let clsStr = registerRouter(cls){
                    classNameList.append(clsStr)
                }
            }
        }
        if URLRouter.isAutoCacheRouter {
            routerClassNameList.append(contentsOf: classNameList)
        }
    }
}
