//
//  Page1ViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/2.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit

@_exported import BeeKit

class Page1ViewController: UIViewController {
    
}
extension Page1ViewController: URLRouterable {
    static func initWith(_ url: URL, options: [String : Any]?) -> UIViewController? {
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page1")
        for item in  (URLComponents(string: url.absoluteString)?.queryItems ?? []) where item.name == "title" {
            rvc.navigationItem.title = "title: \(item.value ?? "")"
        }
        return rvc
    }
}
