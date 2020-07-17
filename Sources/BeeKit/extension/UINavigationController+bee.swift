//
//  UINavigationController+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/5/21.
//

import UIKit

public extension BeeExt where Base: UINavigationController {
    func replaceOrPush(old: UIViewController,new: UIViewController, animated: Bool){
        var vcs = base.viewControllers
        if let idx = vcs.firstIndex(of: old) {
            vcs[idx] = new
            base.setViewControllers(vcs, animated: animated)
        } else {
            base.pushViewController(new, animated: animated)
        }
    }
    
    /// 移除最后一个控制器(只有一个时不移除) 然后 显示新的控制器
    func removeLastAndPush(new: UIViewController, animated: Bool) {
        var vcs = base.viewControllers
        if vcs.count == 1 {
            // 不移除rootController
            base.pushViewController(new, animated: animated)
            return
        }
        vcs.removeLast()
        vcs.append(new)
        base.setViewControllers(vcs, animated: animated)
    }
}
