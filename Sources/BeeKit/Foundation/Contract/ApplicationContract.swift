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
    func bootstrapWith(array: [AnyClass])
}

extension ApplicationContract {
    @discardableResult
    func register(_ provider: ServiceProvider, force: Bool = false) -> ServiceProvider {
        return provider
    }
    public func bootstrapWith(array: [AnyClass]) {
        
    }
}

extension ApplicationContract {
    @discardableResult
    func register<T: ServiceProvider>(_ provider: T, force: Bool = false) -> T {
        return provider
    }
    func terminate() {}
}
