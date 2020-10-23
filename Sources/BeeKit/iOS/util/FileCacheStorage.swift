//
//  FileCache.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/7/28.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation
/// 属性包装 文件缓存
@propertyWrapper
public struct FileCacheStorage<T> {
    let key: String
    let defaultValue: T
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    var filePath:AppDirectories {
        return .file(name: "cache_\(key).json", dir:AppDirectories.dir(name: Contant.bundleIdentifier, dir: .libraryCaches).subDir("BeeKit") )
    }
    public var wrappedValue: T {
        get {
            FileManager.bee.readFile(filePath,type: T.self) ?? defaultValue
        }
        set {
            FileManager.bee.writeFile(filePath, content: newValue)
        }
    }
}
