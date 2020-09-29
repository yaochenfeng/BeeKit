//
//  Reponse.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/28.
//

import Foundation

open class Response {
    var content: Any = ""
    var status: Int = 200
    init(_ content: Any = "", status: Int = 200) {
        self.content = content
        self.status = status
    }
}

extension Response {
    public static func notFound() -> Response {
        return Response(status: 404)
    }
}
