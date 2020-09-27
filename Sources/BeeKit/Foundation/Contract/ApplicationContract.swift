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
}

extension ApplicationContract {
    func register(_ provider: ServiceProvider, force: Bool = false) -> ServiceProvider {
        return provider
    }
}
extension ApplicationContract {
    func register<T: ServiceProvider>(_ provider: T, force: Bool = false) -> T {
        return provider
    }
    func terminate() {}
}
