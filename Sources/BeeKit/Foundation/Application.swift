//
//  Application.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/23.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

public class Application: Container {
    public var version = "0.2.0"
    
    public static let shared = Application()
    override init() {
        super.init()
        registerBaseBindings()
        registerBaseServiceProviders()
        registerCoreContainerAliases()
    }
}

extension Application {
    func registerBaseBindings() {
        instance(type(of: "app"), self)
        instance(Container.self, Container.self)
    }
    func registerBaseServiceProviders() {
        
    }
    func registerCoreContainerAliases() {
        
    }
}
