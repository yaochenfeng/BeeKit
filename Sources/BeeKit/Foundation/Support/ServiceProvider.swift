//
//  ServiceProvider.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

import Foundation

open class ServiceProvider {
    var app: ApplicationContract
    init(_ app: ApplicationContract) {
        self.app = app
    }
}
