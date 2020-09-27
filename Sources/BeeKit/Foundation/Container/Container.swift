//
//  Container.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/25.
//

open class Container: ContainerContract {
    public var instances = [String: AnyObject]()
    
    /// An array of the types that have been resolved.
    public var resolved = [AnyObject]()
    public var aliases = [String: String]()
    
    /// The container's bindings.
    public var bindings = [String]()
    init() {}
}

extension Container {
    public func resolved(_ name: String) -> Bool {
        return false
    }
    public func isShared(_ name: String) -> Bool {
        return instances[name] != nil
    }
    public func isAlias(_ name: String) -> Bool {
        return aliases[name] != nil
    }
    
    /// Get the alias for an abstract if available.
    public func getAlias(_ name: String) -> String {
        return aliases[name] ?? name
    }
    
    func instance(_ name: Any.Type, _ obj: AnyObject) {
    }
}
