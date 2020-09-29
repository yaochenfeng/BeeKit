//
//  ApplicationContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

/// 应用协议
public protocol ApplicationContract: ContainerContract {
    /// 应用版本
    var version: String { get }
    
    /// 是否启动
    var hasBootstrapped: Bool {get set}
    func bootstrapWith(array: [BootStrapContract.Type])
}
public extension ApplicationContract {
    func resolveProvider<T: ServiceProvider>(_ provider: T.Type) -> T {
        return T(app: self)
    }
}

public extension ApplicationContract where Self: Application {
    @discardableResult
    func register<T: ServiceProvider>(_ provider: T.Type, force: Bool = false) -> T? {
        //已注册，非强制覆盖
        if let registered = serviceProviders.map({ pro -> T? in
            return pro as? T
        }).compactMap({$0}).first, !force {
            return registered
        }
        // 未注册
        let service = resolveProvider(T.self)
        service.register()
        
        return nil
    }
    func register<T: ServiceProvider>(register: T.Type) -> T {
        return T(app: self)
    }
    
    
    func bootstrapWith(array: [BootStrapContract.Type]) {
        hasBootstrapped = true
        for bootstrapper in array {
            bootstrapper.init([:]).bootstrap(app: self)
        }
    }
    func terminate() {}
}
