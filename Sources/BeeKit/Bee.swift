//
//  Bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/3/27.
//

import Foundation

/// Tools for
public struct Bee {
    public static func messure(_ name:String, _ function:()->()){
        let start = CACurrentMediaTime()
        function()
        let end = CACurrentMediaTime()
        debugPrint("\(name) execute：\( (end - start) * 1000 ) ms")
    }
}
