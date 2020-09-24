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
    
    func register(_ provider: ServiceProvider, force: Bool) -> ServiceProvider
    func getProviders(_ provider: ServiceProvider) -> [ServiceProvider]
}

extension ApplicationContract {
    func register(_ provider: ServiceProvider, force: Bool = false) -> ServiceProvider {
        return provider
    }
}
