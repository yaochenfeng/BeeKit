//
//  UIView+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/1/21.
//

import UIKit

public extension BeeExt where Base: UIView {
    var controller: UIViewController? {
        var nextView : UIResponder = self.base
        while nextView.next != nil {
            if nextView.next!.isKind(of: UIViewController.self) == true {
                return nextView.next as? UIViewController
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
}
