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
        case TeamsOverview
    }
    static let sharedInstance = ViewControllerProvider()

    var dataProviders: DataProviders?
    
    // MARK: - TodaysGames
    
    func todaysGamesViewController() -> UIViewController {
        let viewController = initialViewControllerFromStoryboard(.TodaysGames)!
        
        if let viewController = viewController.children.first as? TodaysGamesViewController {
            viewController.gamesDataProvider = dataProviders?.gamesDataProvider
        }
        
        return viewController
    }
    
    func liveFeedViewController(liveFeedLink: String, teams: Team) -> UIViewController {
        guard let viewController = viewControllerNamed(LiveFeedViewController.storyBoardID, from: .TodaysGames) as? LiveFeedViewController else {return UIViewController()}
        
        viewController.gamesDataProvider = dataProviders?.gamesDataProvider
        viewController.liveFeedLink = liveFeedLink
        viewController.teams = teams
        
        return viewController
    }
    
    func liveFeedDetailViewController(play: AllPlays) -> UINavigationController {
        guard let navigationController = viewControllerNamed("FeedDetailNavigationController", from: .TodaysGames) as? UINavigationController,
              let viewController = viewControllerNamed(FeedDetailViewController.storyBoardID, from: .TodaysGames) as? FeedDetailViewController
        else {
            return UINavigationController()
        }
        
        viewController.play = play
        navigationController.addChild(viewController)
        navigationController.viewControllers = [viewController]
                
        return navigationController
    }
    
    // MARK: - TeamsOverview
    
    func teamsOverviewViewController() -> UIViewController {
        let viewController = initialViewControllerFromStoryboard(.TeamsOverview)!
        
        if let viewController = viewController.children.first as? TeamsOverviewViewController {
            viewController.teamsDataProvider = dataProviders?.teamsDataProvider
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
