//
//  UIViewController+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/21.
//

import UIKit

public extension BeeExt where Base: UIViewController {
    
    /// 当前可视视图控制器
    @available(swift, deprecated: 5.0, renamed: "topVisible(_:)", message: "Please use topVisible(_:) for the top ")
    static func topVisibleViewController(_ root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        return topVisible(root)
    }
    static func topVisible(_ root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = root as? UINavigationController {
            if nav.visibleViewController is UIAlertController {
                return topVisible(nav.topViewController)
            }
            return topVisible(nav.visibleViewController)
        }
        if let tab = root as? UITabBarController {
            guard let selected = tab.selectedViewController else { return root }
            return topVisible(selected)
        }
        if let presented = root?.presentedViewController {
            if presented is UIAlertController {
                return root
            }
            return topVisible(presented)
        }
        return root
    }
}
