//
//  TeamsTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TeamsTableViewController: UITableViewController {
    
    weak var delegate: TeamsOverviewViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(TeamTableViewCell.nib, forCellReuseIdentifier: TeamTableViewCell.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return teamsData().isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsData().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.reuseIdentifier, for: indexPath) as? TeamTableViewCell else { return UITableViewCell() }
        
        cell.configure(teamName: teamsData()[indexPath.row].name)

        return cell
    }
}

private extension TeamsTableViewController {
    func teamsData() -> [Teams] {
        guard let delegate = delegate else { return [] }
        
        return delegate.getTeams()
    }
    
    func presentLiveFeed(liveFeedLink: String, teams: Team) {
        let viewController = ViewControllerProvider.sharedInstance.liveFeedViewController(liveFeedLink: liveFeedLink, teams: teams)

        navigationController?.pushViewController(viewController, animated: true)
    }
}

