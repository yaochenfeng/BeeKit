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
    
    /// 当前显示的控制器
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
    
    /// 当前显示的导航栏
    static func topNavigation(_ root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UINavigationController? {
        if let nav = root as? UINavigationController {
            return nav
        }
        if let tab = root as? UITabBarController {
            guard let selected = tab.selectedViewController else { return root?.navigationController }
            return topNavigation(selected)
        }
        if let presented = root?.presentedViewController {
            return topNavigation(presented)
        }
        return root?.navigationController
    }
    
    /// 替换或者显示vc
    func replaceOrShow(_ vc:UIViewController, animated: Bool){
        if let nav = base.navigationController {
            nav.bee.replaceOrPush(old: base, new: vc, animated: animated)
        } else {
            if base.presentingViewController == vc {
                base.dismiss(animated: false, completion: nil)
            }
            base.present(vc, animated: animated, completion: nil)
        }
    }
}
