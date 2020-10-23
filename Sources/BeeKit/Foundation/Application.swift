//
//  Application.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/23.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

public class Application: Container {
    public var version = "0.2.0"
    public var isBooted: Bool = false
    public var serviceProviders = [ServiceProvider]()
    
    public static let shared: Application = {
        let app = Application()
        return app
    }()
    required override init() {
        super.init()
        registerBaseBindings()
        registerBaseServiceProviders()
        registerCoreContainerAliases()
    }
}

extension Application: ApplicationContract {
    
    /// 绑定基础存储路径
    func commomInit() {
        
    }
    /// 基础绑定
    func registerBaseBindings() {
        register(Application.self, instance: self)
    }
    
    /// 基础服务
    func registerBaseServiceProviders() {
        
        register(RoutingServiceProvider.self)
    }
    func registerCoreContainerAliases() {
        for (key, value) in ["app": [Self.self, ContainerContract.self, ApplicationContract.self]] {
            for cls in value {
                setAlias(cls, alias: key)
            }
        }
    }
}


class BootstrapServiceProvider: ServiceProvider {
    required init(app: ApplicationContract) {
        self.app = app
    }
    
    var app: ApplicationContract
    
}
