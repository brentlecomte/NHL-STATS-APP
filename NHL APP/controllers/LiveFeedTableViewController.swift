//
//  LiveFeedTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit
import UserNotifications


class LiveFeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var notStarted: UILabel!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var liveFeedtable: UITableView!
    
    var baseURL = "https://statsapi.web.nhl.com"
    var liveFeedLink: String = ""
    var homeTeam: String = ""
    var awayTeam: String = ""
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    var liveFeedData: [AllPlays] = []
    var gameData: Teams?
    var gameTimer: Timer!
    var prevAllPlaysLength: Int = 0
    var liveFeedURL = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //real time live feed
//        liveFeedURL = URL(string: "\(baseURL)\(liveFeedLink)")!
        DispatchQueue.main.async {
            self.gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
        }


//        wanneer er geen feed available is
       liveFeedURL = URL(string: "https://statsapi.web.nhl.com/api/v1/game/2017030213/feed/live")
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(succes, error) in if error != nil {
            print("failed")
        }else{
            print("nailed it")
        }})
        
        loadMatchInfo()
    }
    
    func loadMatchInfo() {
        homeTeamName.text = homeTeam
        awayTeamName.text = awayTeam
        
        homeTeamImage.image = UIImage(named: homeTeam)
        awayTeamImage.image = UIImage(named: awayTeam)
        
    }
    
    @objc func runTimedCode() {
        let task = URLSession.shared.dataTask(with: liveFeedURL!, completionHandler: dataLoaded)
        task.resume()
        
        if(liveFeedData.count == 0) {
            liveFeedtable.isHidden = true
        } else {
            liveFeedtable.isHidden = false
            notStarted.isHidden = true
            if(liveFeedData.count != prevAllPlaysLength) {
                timedNotifications(inSeconds: 1) { (succes) in
                    if succes {
                        print("succes")
                    }
                }
               
                print((liveFeedData.last?.about?.goals.home)!)
                self.homeTeamScore.text = String((liveFeedData.last?.about?.goals.home)!)
                self.awayTeamScore.text = String((liveFeedData.last?.about?.goals.away)!)
                
            } else {
                print("geen veranderingen")
            }
            prevAllPlaysLength = liveFeedData.count
        }
        
        
    
        
    }
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Succes: Bool) -> ()){
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        
        content.title = String((liveFeedData.last?.result.event)!)
        if(liveFeedData.last?.team?.name != nil){
            content.subtitle = String((liveFeedData.last?.team?.name)!)
        }
        content.body = String((liveFeedData.last?.result.event.description)!)
        
        let request = UNNotificationRequest(identifier: "Game Update", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            }else {
                completion(true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do{
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                liveFeedData = jsondata.liveData!.plays.allPlays
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.removeFromSuperview()
                }
            } catch let error{
                print(error)
            }
        }else{
            print(error!)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liveCell", for: indexPath) as! liveCell
        
        let indexNumber = liveFeedData.count-1-indexPath.row
        
        cell.event.text = liveFeedData[indexNumber].result.event
        if(liveFeedData[indexNumber].team?.name != nil) {
             cell.teamImage.image = UIImage(named:(liveFeedData[indexNumber].team?.name)!)
        }
        cell.time.text = liveFeedData[indexNumber].about?.periodTime
        cell.descriptionAction.text = liveFeedData[indexNumber].result.description
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as! FeedDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow
        if(liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].coordinates?.x != nil) {
            detailVC.x = (liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].coordinates?.x)!
            detailVC.y = (liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].coordinates?.y)!
        } else {
            detailVC.x = 0
            detailVC.y = 0
        }
        
        detailVC.descriptionDetail = liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].result.description
        if(liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].team?.name != nil) {
            detailVC.teamName = (liveFeedData[liveFeedData.count-1-(selectedIndexPath?.row)!].team?.name)!
        } else {
            detailVC.teamName = "nhlLogo"
        }
        
    }

    
}
