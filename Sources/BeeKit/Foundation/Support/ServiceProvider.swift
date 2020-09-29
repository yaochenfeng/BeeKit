//
//  ServiceProvider.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

protocol ServiceProvider: class {
    init(app: ApplicationContract)
    var app: ApplicationContract { get }
    
    /// 注册服务
    func register()
    /// 启动
    func boot()
}

extension ServiceProvider {
    func register() {}
    func boot() {}
}
