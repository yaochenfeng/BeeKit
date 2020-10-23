//
//  KernelContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/27.
//

import Foundation

public protocol KernelContract: class {
    
    /// 启动类
    var bootstrappers: [BootStrapContract.Type] {get}
    
    /// Bootstrap the application
    func bootstrap()
    /// 处理请求,先经过全局中间件，再路由中间件
    /// - Parameter request: Request
    @discardableResult
    func handle(request: Request) -> Response
    func terminate(request: Request, response: Response)
    func getApp() -> ApplicationContract
}

public extension KernelContract {
    func bootstrap() {
        let app = getApp()
        guard !app.isBooted else {
            return
        }
        app.bootstrapWith(array: bootstrappers)
    }
    func handle(request: Request) -> Response {
        bootstrap()
        return .notFound()
    }
    func terminate(request: Request, response: Response) {
    }
    
    func getApp() -> ApplicationContract {
        return Application.shared
    }
}
