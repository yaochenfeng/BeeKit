//
//  Page2ViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/2.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit

class Page2ViewController: BaseViewController {
    override class func initWithRouter(_ url: URL, options: [String : Any]?) -> BaseViewController? {
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page2")
        for item in  url.bee.queryDict where item.key == "title" {
            rvc.navigationItem.title = "title: \(item.value)" + Constant.version
        }
        return rvc as? BaseViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
