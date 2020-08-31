//
//  RouterRewriteTests.swift
//  BeeKitTests
//
//  Created by yaochenfeng on 2020/8/31.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import XCTest
@testable import BeeKit
class RouterRewriteTests: XCTestCase {
    func testExample() throws {
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.amazon.com/search/(.*)", target: "protocol://page/routerDetails?product=$1"))
        let rewriteURL = URLRouter.rewriteURL("https://www.amazon.com/search/Atomic_bomb")
        assert("protocol://page/routerDetails?product=Atomic_bomb" ==  rewriteURL, "rewrite错误\(rewriteURL)")
    }
    func testExample2() throws {
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "^(?:https://)?detail(?:.m)?.tmall.com/?item.htm", target: "tmall://page.tm/itemDetail"))
        let rewriteURL = URLRouter.rewriteURL("https://detail.tmall.com/item.htm?hello")
        assert("tmall://page.tm/itemDetail" ==  rewriteURL, "rewrite错误\(rewriteURL)")
        let rewriteURL2 = URLRouter.rewriteURL("https://detail.m.tmall.com/item.htm")
        assert("tmall://page.tm/itemDetail" ==  rewriteURL2, "rewrite错误\(rewriteURL)")
    }
    
    func testPerformanceExample() throws {
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.taobao.com/search/(.*)", target: "protocol://page/routerDetails?id=$$1"))
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.baidu.com/wd/(\\d+)", target: "protocol://page/routerDetails?id=$1"))
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.taobao.com/search/(.*)", target: "protocol://page/routerDetails?id=$$1"))
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.jd.com/search/(.*)", target: "protocol://page/routerDetails?id=$#1"))
        BKRouter.RouterRewrite.add(BKRouter.RewriteRuleItem(match: "(?:https://)?www.amazon.com/search/(.*)", target: "protocol://page/routerDetails?product=$1"))
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let rewriteURL = URLRouter.rewriteURL("https://www.amazon.com/search/Atomic_bomb")
            assert("protocol://page/routerDetails?product=Atomic_bomb" ==  rewriteURL, "rewrite错误\(rewriteURL)")
        }
    }
    
}
