//
//  BeeAppDelegate.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/24.
//

import UIKit
open class BeeAppDelegate: UIResponder, UIApplicationDelegate{
    public var window: UIWindow?
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = Application.shared
        return true
    }
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    open func applicationDidBecomeActive(_ application: UIApplication) {}
}
