//
//  BeeNameSpaceWrapper.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/2.
//

import Foundation

/// 拓展
public protocol BeeExtProtocol {
    associatedtype E
    static var bee: BeeExt<E>.Type {get set }
    var bee: BeeExt<E> { get set }
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

extension Array: BeeExtProtocol {}
extension Dictionary: BeeExtProtocol {}
extension Set: BeeExtProtocol {}
extension String: BeeExtProtocol {}
extension URL: BeeExtProtocol {}

extension NSObject: BeeExtProtocol {}
