//
//  Bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/3/27.
//

import Foundation

/// Tools for BeeKit
public struct Bee {
    public static func messure(_ name:String, _ block:()->()){
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let diff = CFAbsoluteTimeGetCurrent() - start
        debugPrint("\(name) execute：\(diff) seconds")
    }
}
