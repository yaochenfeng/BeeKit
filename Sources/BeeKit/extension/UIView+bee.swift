//
//  UIView+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/21.
//

import UIKit

public extension BeeExt where Base: UIView {
    /// 根据视图生成的图片
    var snapshot: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: base.bounds)
            return renderer.image { rendererContext in
                base.layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(base.bounds.size, base.isOpaque, UIScreen.main.scale)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                return nil
            }
            base.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
    
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
