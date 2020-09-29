//
//  ServiceProvider.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

public protocol ServiceProvider: class {
    init(app: ApplicationContract)
    var app: ApplicationContract { get }
    var isShared: Bool { get }

    /// 注册服务
    func register()
    /// 启动
    func boot()
}

public extension ServiceProvider {
    var isShared: Bool { return false }
    func register() {}
    func boot() {}
}
