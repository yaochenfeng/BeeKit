//
//  Demo3ViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/7.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit

class Page3ViewController: BaseViewController {
    override class func initWithRouter(_ url: URL, options: [String : Any]?) -> Self? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page3") as? Self
    }
}
