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
                self.loadTeamViews()
            }
        }
    }
    
    @IBOutlet private var awayTeamView: UIView!
    @IBOutlet private var homeTeamView: LiveFeedDetailTeamView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LiveFeedViewModel(gamesDataProvider: gamesDataProvider, liveFeedLink: liveFeedLink)
        loadData()
        
        if let tableViewController = children.first as? LiveFeedTableViewController {
            self.tableViewController = tableViewController
            tableViewController.delegate = self
        }
        
//        DispatchQueue.main.async {
//            self.gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
//        }
        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(succes, error) in if error != nil {
//            print("failed")
//        }else{
//            print("nailed it")
//        }})
//
//        loadMatchInfo()
    }
    
    func loadTeamViews() {
        homeTeamView.configure(team: teams, type: .home)
        let teamView = LiveFeedDetailTeamView(frame: awayTeamView.frame)
        awayTeamView.addSubview(teamView)
        NSLayoutConstraint(item: teamView, attribute: .top, relatedBy: .equal, toItem: awayTeamView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: teamView, attribute: .leading, relatedBy: .equal, toItem: awayTeamView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: teamView, attribute: .trailing, relatedBy: .equal, toItem: awayTeamView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: teamView, attribute: .bottom, relatedBy: .equal, toItem: awayTeamView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        view.layoutIfNeeded()
        homeTeamView.contentView.sizeToFit()
        homeTeamView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamView.translatesAutoresizingMaskIntoConstraints = false
//        awayTeamView.contentView.sizeToFit()
    }
    
    func loadData() {
        viewModel?.getLiveFeed({ result in
            switch result {
            case.success(let plays):
                self.plays = plays
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
//    func loadMatchInfo() {
//        homeTeamName.text = homeTeam
//        awayTeamName.text = awayTeam
//
//        homeTeamImage.image = UIImage(named: homeTeam)
//        awayTeamImage.image = UIImage(named: awayTeam)
//
//    }
    
//    @objc func runTimedCode() {
//        let task = URLSession.shared.dataTask(with: liveFeedURL!, completionHandler: dataLoaded)
//        task.resume()
//
//        if(liveFeedData.count == 0) {
//            liveFeedtable.isHidden = true
//        } else {
//            liveFeedtable.isHidden = false
//            notStarted.isHidden = true
//            if(liveFeedData.count != prevAllPlaysLength) {
//                timedNotifications(inSeconds: 1) { (succes) in
//                    if succes {
//                        print("succes")
//                    }
//                }
//
//                print((liveFeedData.last?.about?.goals.home)!)
//                self.homeTeamScore.text = String((liveFeedData.last?.about?.goals.home)!)
//                self.awayTeamScore.text = String((liveFeedData.last?.about?.goals.away)!)
//
//            } else {
//                print("geen veranderingen")
//            }
//            prevAllPlaysLength = liveFeedData.count
//        }
//
//
//
//
//    }
    
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
