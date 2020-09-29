//
//  Reflection.swift
//  BeeKit
//
//  Created by 姚晨峰 on 2020/9/24.
//

import Foundation


/// 反射提供
public class ReflectionProvider {
    public static func resolve<T: AnyObject>(cls: T.Type) {
        let mirror = Mirror(reflecting: cls)
        mirror.superclassMirror
    }
//    public static func logProperty(obj: Any){
//        let mirror = Mirror(reflecting: obj)
//        let dict = mapDic(mirror: mirror)
//        
//        print("dict=\(dict)")
//    }
//    
//    static func mapDic(mirror: Mirror) -> [String: Any] {
//        var dic: [String: Any] = [:]
//        for child in mirror.children {
//            // 如果没有labe就会被抛弃
//            if let label = child.label {
//                let propertyMirror = Mirror(reflecting: child.value)                   dic[label] = child.value
//                mapDic(mirror: propertyMirror)
//            } else {
//                print("value=\(child.value)")
//            }
//        }
//        // 添加父类属性
//        if let superMirror = mirror.superclassMirror {
//            let superDic = mapDic(mirror: superMirror)
//            for p in superDic {
//                dic[p.key] = p.value
//            }
//        }
//        return dic
//    }
}
