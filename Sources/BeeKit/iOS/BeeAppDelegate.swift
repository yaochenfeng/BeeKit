//
//  BeeAppDelegate.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

import UIKit

@UIApplicationMain
@objc open class BeeAppDelegate: UIResponder, UIApplicationDelegate, KernelContract {
    public var bootstrappers: [AnyClass] = []
    
    public var window: UIWindow?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        getApp().instance(self)
        Application.shared.instance(service: KernelContract.self, obj: self)
//            .instance(service: KernelContract.self, obj: self)
        let kernel = getApp().resolve(KernelContract.self)
        let response = kernel?.handle(request: splashRequest) ?? handle(request: splashRequest)
        if let bvc = response.content as? UIViewController {
            window?.rootViewController = bvc
        }
        return true
    }
    
    
    open  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
    open func applicationDidBecomeActive(_ application: UIApplication) {
    }
}

extension KernelContract where Self: UIApplicationDelegate {
    var splashRequest: Request {
        return Request(string: Application.splashRoute)
    }
    public func handle(request: Request) -> Response {
        bootstrap()
        guard let url = URL(string: request.string) else {
            return .notFound()
        }
        let request = URLActionRequest(url)
        return URLRouter.shared.process(request) ?? Response.notFound()
    }
}

extension Application {
    public static var splashRoute: String { return "app://appdelegate/root" }
}
