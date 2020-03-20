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
    
    /// 参数编码后的URL
    var encodeURL: URL? {
        if let url = URL(string: self.base) {
            return url
        }else if let url = URL(string: self.encodeUrlQuery){
            return url
        }
        return nil
    }
}
