//
//  BootStrapContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/29.
//

import Foundation

public protocol BootStrapContract: BeanContract {
    func bootstrap(app: ApplicationContract)
}
