//
//  RoutingServiceProvider.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/27.
//

class RoutingServiceProvider: ServiceProvider {
    var app: ApplicationContract
    var isShared: Bool = true
    
    required init(app: ApplicationContract) {
        self.app = app
    }
}
