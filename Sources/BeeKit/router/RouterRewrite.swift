//
//  RouterRewrite.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/8/31.
//  Copyright © 2020 yaochenfeng. All rights reserved.
//

import Foundation

public extension BKRouter {
    /**
     通过 $scheme、$host、$port、$path、$query、$fragment 获取标准 URL 中的相应部分。通过$url获取完整 URL
     通过 $1、$2、$3...获取matchRule的正则中使用圆括号取出的参数
     $：原变量的值、$$：原变量URL Encode后的值、$#：原变量URL Decode后的值
     */
    class RouterRewrite {//路由
        public static let shared: RouterRewrite = RouterRewrite()
        var rules = [RewriteRuleItem]()
    }
}
public extension BKRouter {
    struct RewriteRuleItem {
        /// 匹配的URL
        var match: String
        
        /// 目标地址
        var target: String
    }
}

extension BKRouter.RouterRewrite {
    public static func rewriteURL(string: String) -> String {
        var targetURL = string
        for rule in shared.rules {
            targetURL = rule.rewrite(targetURL)
        }
        
        return targetURL
    }
    //添加项
    public static func add(_ rule: BKRouter.RewriteRuleItem) {
        remove(matchRule: rule.match)
        shared.rules.append(rule)
    }
    
    public static func remove(matchRule: String) {
        if let idx = shared.rules.firstIndex(where: { item -> Bool in
            return item.match == matchRule
        }) {
            shared.rules.remove(at: idx)
        }
    }
}


extension BKRouter.RewriteRuleItem {
    /**
     通过 $scheme、$host、$port、$path、$query、$fragment 获取标准 URL 中的相应部分。通过$url获取完整 URL
     通过 $1、$2、$3...获取matchRule的正则中使用圆括号取出的参数
     $：原变量的值、$$：原变量URL Encode后的值、$#：原变量URL Decode后的值
     */
    func rewrite(_ originalURL: String) -> String {
//        let matchOptions =
        guard let matchReg = try? NSRegularExpression(pattern: match),
            let result = matchReg.firstMatch(in: originalURL, range: NSRange(location: 0, length: originalURL.count)) else {
                return originalURL
        }
        var targetURL = originalURL
        var groupValues = [String]()
        for idx in 0...matchReg.numberOfCaptureGroups {
            // 从1开始
            let groupRange = result.range(at: idx)
            let replacedValue = (targetURL as NSString).substring(with: groupRange)
            groupValues.append(replacedValue)
        }
        targetURL = target
        if let componentsReg = try? NSRegularExpression(pattern: "[$]([$|#]?)(\\w+)") {
            let urlComponents = URLComponents(string: originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? originalURL)
            componentsReg.enumerateMatches(in: target, range: NSRange(location: 0, length: target.count)) { (result, flags, stop) in
                guard let result = result else {return}
                let matchRange = result.range
                let replacedValue = (target as NSString).substring(with: matchRange)
                let key = replacedValue.filter { char -> Bool in
                    return char.isLetter || char.isNumber
                }
                let convertKey = replacedValue.replacingOccurrences(of: key, with: "")
                if let idx = Int(key), idx >= 0 && idx < groupValues.count {
                    let newValue = self.convertNewValue(groupValues[idx] , convertKey: convertKey)
                    targetURL = targetURL.replacingOccurrences(of: replacedValue, with: newValue)
                } else if let components = urlComponents {
                    var value : String?
                    switch key {
                    case "scheme":
                        value = components.scheme
                    case "host":
                        value = components.host
                    case "port":
                        value = components.port != nil ? "\(components.port ?? 80)" : nil
                    case "path":
                        value = components.path
                    case "query":
                        value = components.query
                    case "fragment":
                        value = components.fragment
                    default:break
                    }
                    if let newValue = value {
                        targetURL = targetURL.replacingOccurrences(of: replacedValue, with: newValue)
                    }
                }
            }
        }
        return targetURL
    }
    
    func convertNewValue(_ origin: String, convertKey: String) -> String {
        if convertKey == "$$" {
            return origin.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? origin
        } else if convertKey == "$#"{
            return origin.removingPercentEncoding ?? origin
        }
        return origin
    }
}


extension URLRouter {
    public static func rewriteURL(_ string: String) -> String {
        return BKRouter.RouterRewrite.rewriteURL(string: string)
    }
}
