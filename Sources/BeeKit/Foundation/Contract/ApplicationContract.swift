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
        // 检查容器是否注册过，如果已经注册过，直接返回容器
        if let registered = serviceProviders.map({ pro -> T? in
            return pro as? T
        }).compactMap({$0}).first, !force {
            return registered
        }
        // 则通过协议解析容器
        let service = resolveProvider(T.self)
        // 调用实例register 方法
        service.register()
        // 将Provider打上已经注册的标识
        // 如果实例需要单例
        if service.isShared {
            instance(service, service: provider)
        }
        return nil
    }
    func register<T: ServiceProvider>(register: T.Type) -> T {
        return T(app: self)
    }
    
    
    func bootstrapWith(array: [BootStrapContract.Type]) {
        hasBootstrapped = true
        for bootstrapper in array {
            bootstrapper.init([:])?.bootstrap(app: self)
        }
    }
    func terminate() {}
}
