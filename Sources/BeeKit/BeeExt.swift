//
//  BeeNameSpaceWrapper.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import Foundation

/// 拓展
public protocol BeeExtProtocol {
    associatedtype ExtendType
    static var bee: BeeExt<ExtendType>.Type {get set }
    var bee: BeeExt<ExtendType> { get set }
}

extension BeeExtProtocol {
    public static var bee: BeeExt<Self>.Type {
        get {
            return BeeExt<Self>.self
        }
        set {}
    }
    public var bee: BeeExt<Self> {
        get {
            return BeeExt(self)
        }
        set {}
    }
}

public struct BeeExt<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: BeeExtProtocol {}
