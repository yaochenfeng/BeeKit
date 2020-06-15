//
//  Constant.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/6/14.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation

/// 应用内常用常亮
public struct Constant {
    /// 版本号
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "unkown"
    /// Build
    static let build = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "unkown"
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.height
    
    /// 作为关联属性使用 库私用
    struct AssociatedKey {
        static var navigation = "com.github.beekit.navigation"
    }
    
}

extension Constant {
    enum Enviroment {
        case prod
        case uat
        case test
        case dev
    }
}
