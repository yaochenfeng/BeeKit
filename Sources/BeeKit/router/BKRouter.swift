//
//  BKRouter.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/8/10.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation

open class BKRouter {
    public static let shared = BKRouter()
    /// 是否自动注册路由
    public static var isAutoLoadRouter = true
    ///是否自动缓存
    public static var isAutoCacheRouter = false
    private init(){}
}

public extension BKRouter {
    func add() {
        
    }
}



