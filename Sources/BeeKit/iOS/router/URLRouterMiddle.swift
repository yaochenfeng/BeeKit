//
//  URLRouterMiddle.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/2/26.
//

import Foundation

public protocol URLRouterMiddleRequest {
    func processRequest(request:URLActionRequest)-> URLActionResponse?
}

public protocol URLRouterMiddleResponse {
    func processResponse(response:URLActionResponse?, request:URLActionRequest)-> URLActionResponse?
}
