//
//  TabbarHandler.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class TabbarHandler: NSObject, URLRouterableExact {
    
    public static var bee_router: String = "beelink://nativePage/switchtab"
    
    static func initWith(req request: URLActionRequest) -> UIViewController? {
        //
        let url = request.url
        guard let tabbar = UIViewController.bee.topVisibleViewController()?.tabBarController else {
            return nil
        }
        guard let str = url.bee.queryDict["index"], let index = Int(str) else {
            return nil
        }
        if let nav = tabbar.selectedViewController as? UINavigationController{
            nav.popToRootViewController(animated: false)
        }
        tabbar.selectedIndex = index
        return nil
    }
}
