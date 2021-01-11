//
//  TeamsOverviewViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/01/2021.
//  Copyright © 2021 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit

protocol TeamsOverviewViewControllerDelegate: class {
    func getTeams() -> [Teams]
}

class TeamsOverviewViewController: UIViewController {
    var teamsDataProvider: TeamsDataProvider?
    
    private var tableViewController: TeamsTableViewController?
    private var teamsOverviewViewModel: TeamsOverviewViewModel?
    
    private var teams: [Teams] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableViewController?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        teamsOverviewViewModel = TeamsOverviewViewModel(teamsDataProvider: teamsDataProvider)
        
        if let tableViewController = children.first as? TeamsTableViewController {
            self.tableViewController = tableViewController
            tableViewController.delegate = self
        }
        
        loadData()
    }
}

private extension TeamsOverviewViewController {
    func loadData() {
        teamsOverviewViewModel?.loadTeams({ result in
            switch result {
            case .success(let teams):
                self.teams = teams
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension TeamsOverviewViewController: TeamsOverviewViewControllerDelegate {
    func getTeams() -> [Teams] {
        return teams
    }
}

