//
//  BeeAppDelegate.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

import UIKit

@UIApplicationMain
@objc open class BeeAppDelegate: UIResponder, UIApplicationDelegate, KernelContract {
    public var bootstrappers: [BootStrapContract.Type] = []
    
    public var window: UIWindow?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let app = Application.shared
        app.instance(self)
        app.instance(self, service: KernelContract.self)
        app.open(Application.splashRoute)
        return true
    }
    
    
    open  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
    open func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}

public extension KernelContract where Self: UIApplicationDelegate {
    var splashRequest: Request {
        return Request(string: Application.splashRoute)
    }
    func handle(request: Request) -> Response {
        bootstrap()
        guard let url = URL(string: request.string) else {
            return .notFound()
        }
        let request = URLActionRequest(url)
        return URLRouter.shared.process(request) ?? Response.notFound()
    }
    func terminate(request: Request, response: Response) {
        guard let bvc = response.content as? UIViewController else {
            return
        }
        guard request == splashRequest else {
            return
        }
        if let keyWind = window {
            keyWind?.rootViewController = bvc
        }
    }
}

@available(iOS, introduced: 8.0)
public extension Application {
    static var splashRoute: String { return "app://appdelegate/root" }
    func open(_ string: String?) -> Response {
        guard let str = string else {
            return .notFound()
        }
        let request = Request(string: str)
        guard let kernel = resolve(KernelContract.self) else {
            return .notFound()
        }
        let response = kernel.handle(request: request)
        kernel.terminate(request: request, response: response)
        return response
    }
    
}
