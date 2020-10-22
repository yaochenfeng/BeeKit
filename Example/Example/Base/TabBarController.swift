//
//  TabBarController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/21.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import BeeKit

class TabBarController: UITabBarController {

    @Autowired var appdelegate: BeeAppKernel?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewControllers()
//        Application.shared.register(WebViewController.self, { container -> Any in
//            return WebViewController(context: container)
//        }, isSingleton: false)
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



class DemoBootstrap: BootStrapContract {
    required init(context: ContainerContract) {
        
    }
    func bootstrap(app: ApplicationContract) {
        
    }
    
}
