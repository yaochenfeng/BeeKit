//
//  UIColor+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/4/13.
//

import UIKit

public extension BeeExt where Base: UIColor {
    /// 随机颜色
    static var random: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       green: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       alpha: 1)
    }
    /// 根据hex创建颜色
    static func initWith(hex: String, alpha:CGFloat = 1.0, alphaFirst: Bool = true) -> UIColor {
        let colorString: String = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        var alpha: CGFloat = alpha
        switch colorString.count {
        case 3://RGB
            red = colorComponent(fromString: colorString, range: 0..<1)
            green = colorComponent(fromString: colorString, range: 1..<2)
            blue = colorComponent(fromString: colorString, range: 2..<3)
        case 6: /// RRGGBB
            red = colorComponent(fromString: colorString, range: 0..<2)
            green = colorComponent(fromString: colorString, range: 2..<4)
            blue = colorComponent(fromString: colorString, range: 4..<6)
        case 8: // AARRGGBB if alphaFirst is true, otherwise RRGGBBAA.
            if alphaFirst {
                alpha = colorComponent(fromString: colorString, range: 0..<2)
                red = colorComponent(fromString: colorString, range: 2..<4)
                green = colorComponent(fromString: colorString, range: 4..<6)
                blue = colorComponent(fromString: colorString, range: 6..<8)
            } else {
                red = colorComponent(fromString: colorString, range: 0..<2)
                green = colorComponent(fromString: colorString, range: 2..<4)
                blue = colorComponent(fromString: colorString, range: 4..<6)
                alpha = colorComponent(fromString: colorString, range: 6..<8)
            }
        default:
            break
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    private static func colorComponent(fromString string: String, range: Range<Int>) -> CGFloat {
        let bef = string.index(string.startIndex, offsetBy: range.startIndex)
        let aft = string.index(string.startIndex, offsetBy: range.endIndex)
        
        let substring: String = String(string[bef..<aft])
        let fullHex = (range.upperBound - range.lowerBound) == 2 ? substring : "\(substring)\(substring)"
        var hexComponent: CUnsignedInt = 0
        Scanner(string: fullHex).scanHexInt32(&hexComponent)

        return CGFloat(hexComponent) / 255.0
    }
}
