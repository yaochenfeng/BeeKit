//
//  RouterTableViewController.swift
//  Example
//
//  Created by yaochenfeng on 2020/1/22.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class RouterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 点击
                guard let cell = tableView.cellForRow(at: indexPath), let urlStr = cell.detailTextLabel?.text else {
        //            super.tableView(tableView, didSelectRowAt: indexPath)
                    return
                }
                URLRouter.shared.open(urlStr.bee.encodeURL, options: nil)

    }
}

extension RouterTableViewController: URLRouterableExact {
    public static var bee_router: String = "beelink://nativePage/routerdemo"
    
    static func initWith(req request: URLActionRequest) -> UIViewController? {
        return UIStoryboard(name: "Router", bundle: nil).instantiateViewController(withIdentifier: "demo")
    }
}


