//
//  ViewController.swift
//  Demo
//
//  Created by 姚晨峰 on 2019/12/26.
//  Copyright © 2019 姚晨峰. All rights reserved.
//

import UIKit
import BeeKit

class DemoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0,
            let cell = tableView.cellForRow(at: indexPath), let urlStr = cell.detailTextLabel?.text else {
//            super.tableView(tableView, didSelectRowAt: indexPath)
            return
        }
        URLRouter.shared.open(urlStr.bee.encodeURL, source: self, options: nil)
        
    }
}

