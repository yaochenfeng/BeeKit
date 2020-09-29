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

    @InjectWrapper var appdelegate: BeeAppDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        Application.shared.resolve(BeeAppDelegate.self)?.bootstrappers.append(DemoBootstrap.self)
        Application.shared.register(WebServceProvider2.self)
        Application.shared.register(WebServceProvider.self)
        
        Application.shared.bind(String.self) { container -> AnyObject in
            return "hello" as NSString
        }
        let web = WebViewController()
        Application.shared.bind("web") { container -> AnyObject in
            return web
        }
        Application.shared.bind(TabBarController.self, builder: { container -> AnyObject in
            return self
        }, shared: false)
        Application.shared.bind(UITabBarController.self, builder: { container -> AnyObject in
            return self
        }, shared: false)
        let app = appdelegate
        print("app\(app)")
        
        Application.shared.resolve(WebViewController.self, name: "web")
//        Application.shared.make("hello")
//        Application.shared.make(ServiceProvider.self)
//         Application.shared.make(WebViewController.self)
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

    static var bee_router: String = Application.splashRoute
}


extension TabBarController: URLRouterableExact {
    static func initWith(req request: URLActionRequest) -> UIViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
}


class DemoBootstrap: BootStrapContract {
    required init(_ params: [String: Any]) {
    }
    func bootstrap(app: ApplicationContract) {
        
    }
    
}
