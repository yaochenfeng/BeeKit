//
//  Container.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/25.
//

open class Container: ContainerContract {
    public init() {}
    
    public var bindings: [String : BeanBinding] = [:]
    
    public var instances = [String: Any]()
    
    /// An array of the types that have been resolved.
    public var resolved = [AnyObject]()
    public var aliases = [String: String]()
}
