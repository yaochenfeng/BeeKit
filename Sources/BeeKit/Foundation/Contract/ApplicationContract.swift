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
    
    /// Boot the application's service providers.
    func boot()
    
    /// Register a new boot listener.
    /// - Parameter callback: function
    func booting(callback: (() -> Void))
    /**
     * Register a new "booted" listener.
     *
     * @param  callable  $callback
     */
    func booted(callback: (() -> Void))
    func register(_ provider: ServiceProvider, force: Bool) -> ServiceProvider
    /// Terminate the application
    func terminate()
}
extension ApplicationContract {
    func register<T: ServiceProvider>(_ provider: T, force: Bool = false) -> T {
        return provider
    }
    func terminate() {}
}
