//
//  UserDefault.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/7/7.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation


/// 属性包装
@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let userDefault: UserDefaults
    
    public init(_ key: String, defaultValue: T, user:UserDefaults? = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefault = user ?? .standard
    }
    
    public var wrappedValue: T {
        get {
            return userDefault.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefault.set(newValue, forKey: key)
        }
    }
}
