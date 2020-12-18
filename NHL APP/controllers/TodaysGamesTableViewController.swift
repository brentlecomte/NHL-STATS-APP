//
//  TodaysGamesTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit
import UserNotifications

class TodaysGamesTableViewController: UITableViewController {
    weak var delegate: TodaysGamesViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(TodaysGamesCell.nib, forCellReuseIdentifier: TodaysGamesCell.reuseIdentifier)
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return gameData().count > 0 ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameData().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodaysGamesCell.reuseIdentifier, for: indexPath) as? TodaysGamesCell else {
            return UITableViewCell()
        }
        
        let gameData = self.gameData()[indexPath.row]
        cell.configure(team: gameData.teams, puckDrop: gameData.dateRange(), venue: "@" + gameData.venue.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameData = self.gameData()[indexPath.row]
        presentLiveFeed(liveFeedLink: gameData.link, teams: gameData.teams)
    }
}

private extension TodaysGamesTableViewController {
    func gameData() -> [Game] {
        guard let delegate = delegate else { return [] }
        
        return delegate.getTodaysGames()
    }
    
    func presentLiveFeed(liveFeedLink: String, teams: Team) {
        let viewController = ViewControllerProvider.sharedInstance.liveFeedViewController(liveFeedLink: liveFeedLink, teams: teams)

        navigationController?.pushViewController(viewController, animated: true)
    }
}
