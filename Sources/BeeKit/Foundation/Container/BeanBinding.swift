//
//  Bean.swift
//  BeeKit
//
//  Created by yaochenfeng on 2020/9/29.
//

public typealias BeanBuilder = (ContainerContract) -> AnyObject
/// 对象生成类
public class BeanBinding {
    var name: String
    let builder: BeanBuilder
    var isShared: Bool
    init(_ name: String, builder: @escaping BeanBuilder, isShared: Bool = false) {
        self.name = name
        self.builder = builder
        self.isShared = isShared
    }
    func resolve<T>(_ container: ContainerContract) -> T? {
        guard let obj = builder(container) as? T else {
            return nil
        }
        if isShared {
            container.instance(obj, name: name)
        }
        return obj
    }
}
