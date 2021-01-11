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
    private var teamsOverviewViewController: UIViewController?
    
    override func viewDidLoad() {
        setViewControllers()
    }
    
    private func setViewControllers() {
        todaysGamesTableViewController = ViewControllerProvider.sharedInstance.todaysGamesViewController()
        todaysGamesTableViewController?.tabBarItem.title = "Live"
        
        teamsOverviewViewController = ViewControllerProvider.sharedInstance.teamsOverviewViewController()
        teamsOverviewViewController?.tabBarItem.title = "TeamsOverview"
        
        viewControllers = [
            todaysGamesTableViewController!,
            teamsOverviewViewController!
        ]

        selectedIndex = 0
    }
}
