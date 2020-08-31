//
//  Serializable.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/8/15.
//

import Foundation


/// 序列化
public protocol Serializable: Codable {}
extension Array : Serializable where Element : Serializable {
    public init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let element = try container.decode(Element.self)
            self.append(element)
        }
    }
}
public extension Serializable {
    //解码
    static func decode(_ jsonString: String)-> Self? {
        let decoder = JSONDecoder()
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        return try? decoder.decode(Self.self, from: jsonData)
    }
    func encode() -> String? {
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    var jsonString: String? {
        return self.encode()
    }
}
