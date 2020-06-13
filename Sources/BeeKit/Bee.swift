//
//  Bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/3/27.
//

import Foundation

/// Tools for
public struct Bee {
    public static func messure(_ name:String, _ block:()->()){
        let start = Date()
        block()
        let end = Date().timeIntervalSince(start)
        debugPrint("\(name) execute：\( end * 1000 ) ms")
    }
}
