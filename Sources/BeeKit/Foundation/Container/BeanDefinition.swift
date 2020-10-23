//
//  Bean.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/29.
//

public typealias BeanBuilder = (ContainerContract) -> Any

/**
 * Any 可以代表任何类型的实例，包括函数类型
 * AnyObject 可以代表任何类类型的实例
 */
public class BeanDefinition {
    var beanType: Any.Type
    init(_ beanType: Any.Type, factory: @escaping BeanBuilder, isSingleton: Bool = false) {
        self.beanType = beanType
        self.factory = factory
        self.isSingleton = isSingleton
    }
    //todo get Metadata
    /// 是否单例
    var isSingleton = false
    
    /// 是否延迟加载
    var isDefer = true
    var factory: BeanBuilder?
    
    func supports<T>(_ type: T.Type) -> Bool {
        return beanType == type
    }
    func resolve(_ container: ContainerContract) -> Any? {
        return factory?(container)
    }
}
