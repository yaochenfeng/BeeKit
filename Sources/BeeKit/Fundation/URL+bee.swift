//
//  URL+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/16.
//

import Foundation

public extension BeeExt where Base == URL {
    var schemeHostPath: String {
        return "\(base.scheme ?? "http")://\(base.host ?? "")\(base.path)"
    }
    var hostPath: String {
        return "\(base.host ?? "")\(base.path)"
    }
    var queryDict: [String: String] {
        
        guard let component = URLComponents.init(string: self.base.absoluteString), let queryItemList = component.queryItems else {
            return [:]
        }
        var para : [String : String] = [:]
        for item in queryItemList {
            para[item.name] = item.value
        }
        return para
    }
}

