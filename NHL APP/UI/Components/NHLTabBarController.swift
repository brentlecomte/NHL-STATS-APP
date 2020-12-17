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
    private var todaysGamesTableViewController: TodaysGamesTableViewController?
    
    override func viewDidLoad() {
        setViewControllers()
        
        addNavBarImage()
    }
    
    private func setViewControllers() {
        todaysGamesTableViewController = ViewControllerProvider.sharedInstance.todaysGamesTableViewController()
        todaysGamesTableViewController?.tabBarItem.title = "Live"
        
        viewControllers = [
            todaysGamesTableViewController!
        ]

        selectedIndex = 0
    }
    
    private func addNavBarImage () {
        let image = #imageLiteral(resourceName: "nhlLogo")
        let imageView = UIImageView(image: image)
        
        if let bannerWidth = navigationController?.navigationBar.frame.size.width, let bannerHeight = navigationController?.navigationBar.frame.size.height {
            let bannerX = (bannerWidth )/2 - image.size.width/2
            let bannerY = (bannerHeight )/2 - image.size.height/2
            
            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        }
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}
