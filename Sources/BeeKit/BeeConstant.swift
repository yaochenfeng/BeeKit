//
//  BeeConstant.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/6/22.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation

public struct BeeContant {
    static let version: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "unkown"
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier ?? "unkown"

}
