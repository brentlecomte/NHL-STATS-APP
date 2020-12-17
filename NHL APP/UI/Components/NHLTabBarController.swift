//
//  NHLTabBarController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit
class NHLTabBarController: UITabBarController, UITabBarControllerDelegate {
    private var todaysGamesTableViewController: UIViewController?
    
    override func viewDidLoad() {
        setViewControllers()
    }
    
    private func setViewControllers() {
        todaysGamesTableViewController = ViewControllerProvider.sharedInstance.todaysGamesTableViewController()
        todaysGamesTableViewController?.tabBarItem.title = "Live"
        
        viewControllers = [
            todaysGamesTableViewController!
        ]

        selectedIndex = 0
    }
}
