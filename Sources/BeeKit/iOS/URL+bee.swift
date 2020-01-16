//
//  URL+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/16.
//

import Foundation

extension URL: BeeExtProtocol {}

public extension BeeExt where Base == URL {
    var schemeHostPath: String {
        return "\(base.scheme ?? "http")://\(base.host ?? "")\(base.path)"
    }
    var hostPath: String {
        return "\(base.host ?? "")\(base.path)"
    }
}

