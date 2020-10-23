//
//  ApplicationContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

/**
 * 应用程序协议，控制反转
 * Bootstrap 应用启动阶段准备工作,加载配置
 * 准备-> 启动 -> 响应
 */
public protocol ApplicationContract: ContainerContract {
    /// 应用版本
    var version: String { get }
    /// 是否启动
    var isBooted: Bool { get set }
    /// 服务
    var serviceProviders: [ServiceProvider] { get }
    func bootstrapWith(array: [BootStrapContract.Type])
    /// 应用启动
    func boot()
}

public extension ApplicationContract where Self: Application {
    @discardableResult
    func register<T: ServiceProvider>(_ provider: T.Type, force: Bool = false) -> T {
        // 检查容器是否注册过，如果已经注册过，直接返回容器
        if let registered = getProvider(provider), !force {
            return registered
        }
        // 则通过协议解析容器
        let service = resolve(T.self) ?? T.init(app: self)
        // 调用实例register 方法
        service.register()
        // 将Provider打上已经注册的标识
        if isBooted {
            service.boot()
        }
        // 如果实例需要单例
        if service.isShared {
            serviceProviders.append(service)
        }
        return service
    }
    
    func bootstrapWith(array: [BootStrapContract.Type]) {
        for bootstrapper in array {
            bootstrapper.init(context: self).bootstrap(app: self)
        }
        boot()
    }
    func terminate() {}
    
    func boot() {
        guard !isBooted else { return }
        for service in serviceProviders {
            service.boot()
        }
        isBooted = true
    }
    
    func getProvider<T: ServiceProvider>(_ provider: T.Type) -> T? {
        return serviceProviders.map { service -> T? in
            return service as? T
        }.compactMap{$0}.first
    }
}
