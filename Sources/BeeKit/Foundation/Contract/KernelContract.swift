//
//  KernelContract.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/27.
//

import Foundation

public protocol KernelContract {
    
    /// Bootstrap the application
    func bootstrap()
    func handle(request: Any)
}

extension KernelContract {
    
}
