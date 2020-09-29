//
//  Request.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/27.
//

import Foundation

open class Request {
    var string: String
    init(string: String) {
        self.string = string
    }
}
extension Request: Equatable {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.string == rhs.string
    }
}
