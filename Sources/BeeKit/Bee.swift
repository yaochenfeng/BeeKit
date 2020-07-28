//
//  Bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/3/27.
//

import Foundation
// 2) we need to create a logger, the label works similarly to a DispatchQueue label
let logger = Logger(label: "com.github.yaochenfeng.BeeKit")
/// Tools for BeeKit
public struct Bee {
    public static func messure(_ name:String, _ block:()->()){
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let diff = CFAbsoluteTimeGetCurrent() - start
        logger.info("\(name)代码执行时长：\(diff * 1000) 毫秒")
    }
}
