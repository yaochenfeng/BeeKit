//
//  AutowiredWrapper.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/29.
//

import Foundation


@propertyWrapper
public struct InjectWrapper<T> {
    public init() {
    }
    public var wrappedValue: T? {
        get {
            return Application.shared.resolve(T.self)
        }
    }
}
