//
//  Page2ViewController.swift
//  Demo
//
//  Created by yaochenfeng on 2020/1/2.
//  Copyright © 2020 姚晨峰. All rights reserved.
//

import UIKit

class Page2ViewController: BaseViewController {
    override class func initWithRouter(_ url: URL, options: [String : Any]?) -> Self? {
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page2")
        for item in  (URLComponents(string: url.absoluteString)?.queryItems ?? []) where item.name == "title" {
            rvc.navigationItem.title = "title: \(item.value ?? "")"
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
