//
//  AppDelegate.swift
//  Demo
//
//  Created by 姚晨峰 on 2019/12/26.
//  Copyright © 2019 姚晨峰. All rights reserved.
//

import UIKit
@_exported import BeeKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var convertOption : [String : Any] = [:]
        for key in options.keys {
            let value = options[key]
            convertOption[key.rawValue] = value
        }
        if URLRouter.shared.canOpen(with: url) {
            URLRouter.shared.open(url, source: AppDelegate.topViewController(), options: convertOption)
        }
        return true
    }

    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            if nav.visibleViewController is UIAlertController {
                return topViewController(nav.topViewController)
            }
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            guard let selected = tab.selectedViewController else { return base }
            return topViewController(selected)
        }
        if let presented = base?.presentedViewController {
            if presented is UIAlertController {
                return base
            }
            return topViewController(presented)
        }
        return base
    }

}

