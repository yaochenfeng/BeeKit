//
//  UIImageTests.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/5/21.
//

import XCTest
@testable import BeeKit

final class UIImageTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testColorInit() {
        let img = UIImage.bee.initWith(color: .red, size: CGSize(width: 30, height: 30))
        assert(img != nil, "图片创建失败")
    }
    func testColorInitRadius() {
        let img = UIImage.bee.initWith(color: .red, size: CGSize(width: 30, height: 30), cornerRadius: 8.0)
        assert(img != nil, "图片创建失败")
    }
    func testColorInitRadiusCorners() {
        let img = UIImage.bee.initWith(color: .red, size: CGSize(width: 30, height: 30), cornerRadius: 8.0, corners: UIRectCorner.topLeft)
        assert(img != nil, "图片创建失败")
    }
}
