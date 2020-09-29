//
//  ContainerContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

/// IOC容器协议
public protocol ContainerContract: class {
    var instances: [String: Any] { get }
    var bindings: [String: BeanBinding] { get }
    var aliases: [String: String] { get }
    
    func instance(_ obj: AnyObject, name: String?)
    func instance<T>(_ obj: T, name: String?)
}

public extension ContainerContract {
    func getAlias(_ service: AnyClass) -> String {
        let alias = "\(service)"
        return aliases[alias] ?? alias
    }
    /// Get the alias for an abstract if available.
    func getAlias(_ service: String) -> String {
        return aliases[service] ?? service
    }
    func isAlias(_ service: AnyClass) -> Bool {
        let alias = "\(service)"
        return aliases[alias] != nil
    }
}

public extension ContainerContract {
    func isShared(_ service: String) -> Bool {
        let alias = getAlias(service)
        guard instances[service] == nil else { return true }
        return bindings[alias]?.isShared ?? false
    }
    /// 根据类和协议找到对应实例 或 初始化实例
    /// - Parameter abstract: Class or Protocol
    /// - Returns: 实例
    func resolve<T>(_ abstract: T.Type) -> T? {
        let alias = getAlias("\(abstract)")
        if let instance = instances[alias] as? T {
            return instance
        }
        guard let binding = bindings[alias] else {
            return nil
        }
        return binding.resolve(self)
    }
    
    func resolved(_ service: String) -> Bool {
        return false
    }
}

public extension ContainerContract where Self: Container {
    func setAlias(_ key: String, alias: Any)  {
        aliases["\(alias)"] = key
    }
    /// Register a binding with the container.
    func bind(_ name: String, builder:@escaping BeanBuilder, shared: Bool = false) {
        let alias = getAlias(name)
        bindings[alias] = BeanBinding(alias, builder: builder)
    }
    func instance<T>(service: T.Type, obj: Any) {
        let alias = getAlias("\(service)")
        instances[alias] = obj as AnyObject
    }
    func instance<T>(_ obj: T, name: String? = nil) {
        
    }
    func instance<T>(service: T.Type, obj: T) {
        
    }
    func instance(service: Protocol, obj: AnyObject) {
        
    }
}
