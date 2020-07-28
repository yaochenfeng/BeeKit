//
//  AppDelegate.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/21.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
@_exported import BeeKit

@UIApplicationMain
class AppDelegate: BeeAppDelegate {

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let res = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        URLRouter.isAutoCacheRouter = true
        // Override point for customization after application launch.
        URLRouter.shared.add(RouterRewriteMiddleRequest())

        return true
    }
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        super.application(app, open: url, options: options)
        var convertOption : [String : Any] = [:]
        for key in options.keys {
            let value = options[key]
            convertOption[key.rawValue] = value
        }
        if URLRouter.shared.canOpen(with: url, options: convertOption) {
            URLRouter.shared.open(url, options: convertOption)
        }
        return true
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
    }

}
class FlutterAppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }
}

class FlutterAppDelegate2: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return false
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}
