//
//  ContainerContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

/// IOC容器协议
public protocol ContainerContract: class {
    var instances: [String: Any] { get set }
    /// 类绑定
    var bindings: [String: BeanDefinition] { get set }
    
    /// 类对应的别名
    var aliases: [String: String] { get  set }
}

public extension ContainerContract {
    
    /// 注册单例
    @discardableResult
    func register<T>(_ interface: T.Type, instance: T) -> Self {
        instances[getAlias(interface)] = instance
        return self
    }
    /// 注册类和实例初始化方法
    @discardableResult
    func register<T>(_ type: T.Type, _ factory: @escaping BeanBuilder, isSingleton: Bool = false) -> Self {
        let beanDefine = BeanDefinition(type, factory: factory, isSingleton: isSingleton)
        bindings[getAlias(type)] = beanDefine
        return self
    }
    
    /// 设置别名
    /// - Parameters:
    ///   - type: 类型
    ///   - alias: 别名
    func setAlias(_ key: Any, alias: String) {
        aliases["\(key)"] = alias
    }
    func getAlias(_ key: Any) -> String {
        let alias = "\(key)"
        return aliases[alias] ?? alias
    }
}

public extension ContainerContract {
    /// 根据类返回实例
    /// - Parameter type: Service class
    @discardableResult
    func resolve<T>(_ type: T.Type) -> T? {
        let alas = getAlias(type)
        if  let obj = instances[alas] as? T {
            return obj
        }
        let beanDefine =  bindings[alas]
        if let bean = beanDefine?.resolve(self) as? T {
            return bean
        }
        guard let pro = type as? BeanContract.Type, let bean = pro.init(context: self) as? T else {
            return nil
        }
        return bean
    }
    subscript<T>(service: T.Type) -> T? {
        set {
            guard let obj = newValue else {return}
            register(T.self, instance: obj)
        }
        get {
            return resolve(T.self)
        }
    }
}
