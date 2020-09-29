//
//  Application.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/23.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

public class Application: Container {
    public var version = "0.2.0"
    public var hasBootstrapped: Bool = false
    
    var serviceProviders = [ServiceProvider]()
    
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
    
    /// 基础绑定
    func registerBaseBindings() {
        instance(self, name: "app")
        instance(self)
        register(BootstrapServiceProvider(app: self))
    }
    
    /// 基础服务
    func registerBaseServiceProviders() {
        
    }
    func registerCoreContainerAliases() {
        for (key, value) in ["app": [Self.self, ContainerContract.self, ApplicationContract.self]] {
            for aliasName in value {
                setAlias(key, alias: aliasName)
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
