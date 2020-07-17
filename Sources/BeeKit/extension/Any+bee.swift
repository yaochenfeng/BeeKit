//
//  Any+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/6/13.
//

public extension BeeExt where Base: Any {
    func then(_ block: (Base) throws -> Void) rethrows -> Base {
        try block(self.base)
        return self.base
    }
}
