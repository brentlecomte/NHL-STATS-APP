//
//  LiveFeedViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit
import UserNotifications

protocol LiveFeedViewControllerDelegate: class {
    func allPlays() -> [AllPlays]
}

class LiveFeedViewController: UIViewController {
    static let storyBoardID = "LiveFeedViewController"
    
    private var viewModel: LiveFeedViewModel?
    private var gameTimer: Timer?
    private var tableViewController: LiveFeedTableViewController?
    
    var gamesDataProvider: GamesDataProvider?
    var liveFeedLink = ""
    var teams: Team?
    
    private var plays = [AllPlays]() {
        didSet {
            DispatchQueue.main.async {
                self.tableViewController?.tableView.reloadData()
            }
        }
    }
    
    private var currentPlay: CurrentPlay? {
        didSet {
            DispatchQueue.main.async {
                self.loadTeamViews()
            }
        }
    }
    
    @IBOutlet private var awayTeamView: LiveFeedDetailTeamView!
    @IBOutlet private var homeTeamView: LiveFeedDetailTeamView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LiveFeedViewModel(gamesDataProvider: gamesDataProvider, liveFeedLink: liveFeedLink)
        loadData()
        
        if let tableViewController = children.first as? LiveFeedTableViewController {
            self.tableViewController = tableViewController
            tableViewController.delegate = self
        }
        
        DispatchQueue.main.async {
            self.gameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.loadData), userInfo: nil, repeats: true)
        }
        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(succes, error) in if error != nil {
//            print("failed")
//        }else{
//            print("nailed it")
//        }})
    }
    
    func loadTeamViews() {
        homeTeamView.configure(team: teams, currentPlay: currentPlay, type: .home)
        awayTeamView.configure(team: teams, currentPlay: currentPlay, type: .away)
    }
    
    @objc func loadData() {
        viewModel?.getLiveFeed({ result in
            switch result {
            case.success(let plays):
                self.plays = plays.allPlays
                self.currentPlay = plays.currentPlay
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
//    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Succes: Bool) -> ()){
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
//
//        let content = UNMutableNotificationContent()
//
//        content.title = String((liveFeedData.last?.result.event)!)
//        if(liveFeedData.last?.team?.name != nil){
//            content.subtitle = String((liveFeedData.last?.team?.name)!)
//        }
//        content.body = String((liveFeedData.last?.result.event.description)!)
//
//        let request = UNNotificationRequest(identifier: "Game Update", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { (error) in
//            if error != nil {
//                completion(false)
//            }else {
//                completion(true)
//            }
//        }
//    }
}

extension LiveFeedViewController: LiveFeedViewControllerDelegate {
    func allPlays() -> [AllPlays] {
        return plays
    }
    
    
}
