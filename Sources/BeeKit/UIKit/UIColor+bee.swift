//
//  UIColor+bee.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/4/13.
//

import Foundation
public extension BeeExt where Base: UIColor {
    static var random: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       green: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       blue: CGFloat(arc4random_uniform(255))/CGFloat(255.0),
                       alpha: 1)
    }
    static func initWith(hex: String) -> UIColor {
        let colorString: String = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var alpha: CGFloat = 1.0, red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        switch colorString.count {
        case 3://RGB
            alpha = 1.0
            red = colorComponent(fromString: colorString, range: 0..<1)
            green = colorComponent(fromString: colorString, range: 1..<2)
            blue = colorComponent(fromString: colorString, range: 2..<3)
        case 6: /// RRGGBB
            alpha = 1.0
            red = colorComponent(fromString: colorString, range: 0..<2)
            green = colorComponent(fromString: colorString, range: 2..<4)
            blue = colorComponent(fromString: colorString, range: 4..<6)
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
