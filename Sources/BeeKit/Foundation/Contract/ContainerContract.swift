//
//  ContainerContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//


/// IOC容器协议
public protocol ContainerContract {
}


extension ContainerContract {
    
    /// 为服务注册服务提供者
    /// - Returns: 服务
    func bind<T: Protocol>(service: T.Type, instance: T) -> T? {
        return instance
    }
    func instance(_ abstract: Protocol){
        
    }
    func resolve<T: Protocol>(_ abstract: T) -> T? {
        return nil
    }
}
