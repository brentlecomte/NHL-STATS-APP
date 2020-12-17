//
//  TodaysGamesViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit

protocol TodaysGamesViewControllerDelegate: class {
    func getTodaysGames() -> [Game]
}

class TodaysGamesViewController: UIViewController {
    var gamesDataProvider: GamesDataProvider?
    
    private var viewModel: TodaysGamesTableViewViewmodel?
    private var tableViewController: TodaysGamesTableViewController?
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    static let storyBoardID = "TodaysGamesViewController"
    
    var gameData: [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewController?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        viewModel = TodaysGamesTableViewViewmodel(gamesDataProvider: gamesDataProvider)
        
        loadData()
        addNavBarImage()
        
        if let tableViewController = children.first as? TodaysGamesTableViewController {
            self.tableViewController = tableViewController
            tableViewController.delegate = self
        }
    }
}

private extension TodaysGamesViewController {
    func loadData() {
        viewModel?.loadSchedule({ result in
            self.presentActivityIndicator(hide: false)
            switch result {
            case .success(let games):
                self.gameData = games
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        self.presentActivityIndicator()
    }
    
    func presentActivityIndicator(hide: Bool = true) {
        DispatchQueue.main.async {
            if hide {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            } else {
                self.activityIndicator.startAnimating()
                self.view.addSubview(self.activityIndicator)
            }
        }
    }
    
    func addNavBarImage() {
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

extension TodaysGamesViewController: TodaysGamesViewControllerDelegate {
    func getTodaysGames() -> [Game] {
        return gameData
    }
}
