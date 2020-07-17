//
//  UIImage+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/5/21.
//

import UIKit

public extension BeeExt where Base: UIImage {
    
    /// 创建图片
    ///   - color: 图片颜色
    ///   - size: 大小
    ///   - cornerRadius: 圆角
    ///   - corners: 需要圆角的边
    static func initWith(color: UIColor,
                         size: CGSize,
                         cornerRadius: CGFloat = 0,
                         corners: UIRectCorner = .allCorners) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let rect = CGRect(origin: .zero, size: size)
        let bezier = UIBezierPath(roundedRect: rect,
                                  byRoundingCorners: corners,
                                  cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        bezier.addClip()
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.addPath(bezier.cgPath)
        context?.fill(rect)
        let resImg = UIGraphicsGetImageFromCurrentImageContext()
        return resImg
    }
}
