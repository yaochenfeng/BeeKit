//
//  BeanContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/29.
//

import Foundation

public protocol BeanContract: class {
    init?(_ params: [String: Any])
}
