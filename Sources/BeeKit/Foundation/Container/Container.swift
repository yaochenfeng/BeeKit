//
//  Container.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/25.
//

open class Container: ContainerContract {
    public init() {}
    
    /// 绑定类
    public var bindings: [String: BeanDefinition] = [:]
    
    public var instances = [String: Any]()
    public var aliases = [String: String]()
}
