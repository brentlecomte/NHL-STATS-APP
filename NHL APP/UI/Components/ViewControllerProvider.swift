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
    
    func todaysGamesTableViewController() -> TodaysGamesTableViewController {
        let tableViewController = viewControllerNamed(TodaysGamesTableViewController.storyBoardID, from: .TodaysGames) as! TodaysGamesTableViewController
        tableViewController.gamesDataProvider = dataProviders?.gamesDataProvider
        return tableViewController
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
