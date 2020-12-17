//
//  TodaysGamesTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit
import UserNotifications

class TodaysGamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noGamesimage: UIImageView!
    @IBOutlet weak var noGames: UILabel!
    
    static let storyBoardID = "TodaysGamesTableViewController"
    
    private var viewModel: TodaysGamesTableViewViewmodel?
    var gamesDataProvider: GamesDataProvider?
    
    var gameTimer: Timer!
    
    var gameData: [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodaysGamesTableViewViewmodel(gamesDataProvider: gamesDataProvider)
        addNavBarImage()
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        tableView.register(TodaysGamesCell.nib, forCellReuseIdentifier: TodaysGamesCell.reuseIdentifier)
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 239
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameData.count > 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodaysGamesCell.reuseIdentifier, for: indexPath) as? TodaysGamesCell else {
            return UITableViewCell()
        }
        
        // To-Do: clean this up
        let date = gameData[indexPath.row].gameDate
        
        let start = date.index(date.startIndex, offsetBy: 11)
        let end = date.index(date.endIndex, offsetBy: -4)
        let range = start..<end
//        liveFeed = gameData[indexPath.row].link
        
        cell.configure(team: gameData[indexPath.row].teams, puckDrop: String(date[range]), venue: "@" + gameData[indexPath.row].venue.name, score: (1, 0))
        
        return cell
    }
    
    private func loadData() {
        viewModel?.loadSchedule({ result in
            switch result {
            case .success(let games):
                self.gameData = games
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let detailVC = segue.destination as! LiveFeedTableViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow
        detailVC.liveFeedLink = gameData[(selectedIndexPath?.row)!].link
        detailVC.homeTeam = (gameData[(selectedIndexPath?.row)!].teams.home.team?.name)!
        detailVC.awayTeam = (gameData[(selectedIndexPath?.row)!].teams.away.team?.name)!
    }
}

private extension TodaysGamesTableViewController {
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
