//
//  ViewControllerProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerProvider {
    enum Storyboard: String {
        case Main
        case TodaysGames
    }
    static let sharedInstance = ViewControllerProvider()

    var dataProviders: DataProviders?
    
    func todaysGamesTableViewController() -> UIViewController {
        let viewController = initialViewControllerFromStoryboard(.TodaysGames)!
        
        if let tableViewController = viewController.children.first as? TodaysGamesTableViewController {
            tableViewController.gamesDataProvider = dataProviders?.gamesDataProvider
        }
        
        return viewController
    }
}

private extension ViewControllerProvider {
    func initialViewControllerFromStoryboard(_ storyboard: Storyboard) -> UIViewController? {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController()
    }
    
    func viewControllerNamed(_ name: String, from storyboard: Storyboard) -> UIViewController? {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
