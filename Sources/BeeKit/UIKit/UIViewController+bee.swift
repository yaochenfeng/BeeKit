//
//  UIViewController+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/21.
//

import UIKit

public extension BeeExt where Base: UIViewController {
    
    /// 当前可视视图控制器
    static func topVisibleViewController(_ root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = root as? UINavigationController {
            if nav.visibleViewController is UIAlertController {
                return topVisibleViewController(nav.topViewController)
            }
            return topVisibleViewController(nav.visibleViewController)
        }

        if let tab = root as? UITabBarController {
            guard let selected = tab.selectedViewController else { return root }
            return topVisibleViewController(selected)
        }
        if let presented = root?.presentedViewController {
            if presented is UIAlertController {
                return root
            }
            return topVisibleViewController(presented)
        }
        return root
    }
}
