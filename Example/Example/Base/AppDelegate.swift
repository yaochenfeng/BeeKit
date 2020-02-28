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
//        self.add(FlutterAppDelegate(), name: "flutter")
//        self.responds(to: #selector(applicationWillResignActive(_:)))
        print(res)
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

        if URLRouter.shared.canOpen(with: url, source: UIViewController.bee.topVisibleViewController(), options: convertOption) {
            URLRouter.shared.open(url, source: UIViewController.bee.topVisibleViewController(), options: convertOption)
        }
        return true
    }
    @objc
    override func applicationDidBecomeActive(_ application: UIApplication) {
        let res =  super.applicationDidBecomeActive(application)
        print(res)
    }
    

}


class FlutterAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            return false
        }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("flutter become")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        print("flutter applicationWillResignActive")
    }
}

//@available(iOS 13.0, *)
//extension AppDelegate {
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//}

