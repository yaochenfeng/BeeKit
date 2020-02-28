//
//  TabBarController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/21.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViewControllers()
    }
    
    func updateViewControllers(){
        let childs = viewControllers
        var navs = [NavigationController]()
        for child in childs ?? [] {
            if let vc = child as? UINavigationController, let root = vc.viewControllers.first {
                let nav = NavigationController(rootViewController: root)
                nav.tabBarItem = vc.tabBarItem
                navs.append(nav)
            } else {
                let nav = NavigationController(rootViewController: child)
                nav.tabBarItem = child.tabBarItem
                navs.append(nav)
            }
        }
        setViewControllers(navs, animated: false)
    }

}
