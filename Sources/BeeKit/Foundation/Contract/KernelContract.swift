//
//  KernelContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/27.
//

import Foundation

public protocol KernelContract: class {
    /// Bootstrap the application
    func bootstrap()
    
    /// 处理请求,先经过全局中间件，再路由中间件
    /// - Parameter request: Request
    func handle(request: Request) -> Response
    func getApp() -> ApplicationContract
    
    var bootstrappers: [BootStrapContract.Type] {get}
}

extension KernelContract {
    public func bootstrap() {
        let app = getApp()
        guard !app.hasBootstrapped else {
            return
        }
        app.hasBootstrapped = true
        app.bootstrapWith(array: bootstrappers)
    }
    public func handle(request: Request) -> Response {
        bootstrap()
        return .notFound()
    }
    
    public func getApp() -> ApplicationContract {
        return Application.shared
    }
}
