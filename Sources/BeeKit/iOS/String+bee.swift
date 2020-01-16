//
//  String+bee.swift
//  Pods
//
//  Created by yaochenfeng on 2020/1/2.
//

import Foundation

extension String: BeeExtProtocol {}

public extension BeeExt where Base == String {
    var encodeUrlQuery: String {
        return self.base.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
