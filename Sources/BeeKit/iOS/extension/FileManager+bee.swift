//
//  FileManager+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/6/22.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation


/// 文件枚举
public enum AppDirectories {
    case home
    /// documents  保存应用运行时生成的需要持久化的数据，iTunes同步设备时会备份该目录
    case documents
    case library
    case libraryCaches
    /// 保存应用运行时所需要的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行，系统也可能会清除该目录下的文件
    case temp
    indirect case file(name: String, dir: AppDirectories)
    indirect case dir(name:String, dir: AppDirectories)
    
    var filePathString: String {
        switch self {
        case .file(let name, let dir):
            return dir.directoryPath + "/" + name
        default:
            return directoryPath
        }
    }
    var fileURL: URL {
        return URL(fileURLWithPath: filePathString)
    }
    var directoryPath: String {
        switch self {
        case .home:
            return NSHomeDirectory()
        case .documents:
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        case .library:
            return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        case .libraryCaches:
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        case .temp:
            return NSTemporaryDirectory()
        case .file(_, let dir):
            return dir.directoryPath
        case .dir(let name, let dir):
            return dir.directoryPath + "/" + name
        }
    }
    func subDir(_ name: String) -> AppDirectories{
        return AppDirectories.dir(name: name, dir: self)
    }
}
public extension BeeExt where Base: FileManager {
    
    /// 写入文件
    /// - Parameters:
    ///   - path: 文件地址 目录不存在就创建目录
    ///   - content: 文件内容
    /// - Returns: 是否写入成功
    @discardableResult
    static func writeFile(_ path: AppDirectories, content: Any, options: Data.WritingOptions = []) -> Bool {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: content, options: [])
            if !FileManager.default.fileExists(atPath: path.directoryPath) {
                try FileManager.default.createDirectory(atPath: path.directoryPath, withIntermediateDirectories: true, attributes: nil)
            }
            try data.write(to: path.fileURL, options: options)
            return true
        } catch {
            return false
        }
    }
    static func readFile<T>(_ path: AppDirectories, type: T.Type) -> T? {
        guard let content = FileManager.default.contents(atPath: path.filePathString), content.isEmpty == false else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: content, options: []) as? T
    }
}
