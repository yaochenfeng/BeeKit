//
//  SplashController.swift
//  Example
//
//  Created by 姚晨峰 on 2020/9/30.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import BeeKit
class SplashController: UIViewController {
    static var bee_router: String = Application.splashRoute
    static var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func toggleTabAction(_ sender: Any) {
        Application.shared.open(Application.splashRoute)
        Self.index = Self.index + 1
    }
    
}

extension SplashController: URLRouterableExact {
    static func initWith(req request: URLActionRequest) -> UIViewController? {
        if index % 2 == 0 {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splash")
        } else {
            return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
