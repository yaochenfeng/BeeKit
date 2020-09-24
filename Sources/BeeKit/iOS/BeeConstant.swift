//
//  BeeConstant.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/6/22.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation

/// 应用常用常量
public struct BeeContant {
    /// APP版本号
    static let version: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "unkown"
    /// APP bundleId
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier ?? "unkown"

}
