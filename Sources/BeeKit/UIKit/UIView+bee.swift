//
//  UIView+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/21.
//

import UIKit

public extension BeeExt where Base: UIView {
    
    /// 对应的控制器
    var controller: UIViewController? {
        var nextView : UIResponder = self.base
        while nextView.next != nil {
            if let vc = nextView.next as? UIViewController {
                return vc
            } else {
                nextView = nextView.next!
            }
        }
        return nil;
    }
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return base.safeAreaInsets
        } else {
            return .zero
        }
    }
    /// 添加子视图数组
    func addSubViews(_ views: [UIView]) {
        for view in views {
            base.addSubview(view)
        }
    }
}
