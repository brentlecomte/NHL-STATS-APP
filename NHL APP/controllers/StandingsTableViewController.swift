//
//  StandingsTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 08/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class StandingsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var standingsURL: URL = URL(string: "https://statsapi.web.nhl.com/api/v1/standings")!
    
    @IBOutlet weak var tableView: UITableView!
    var standingData: [Records] = []
    var teams: [String] = []
    var gamesPlayed: [Int] = []
    var overTime: [Int] = []
    var wins: [Int] = []
    var loses: [Int] = []
    var points: [Int] = []
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStandings()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func loadStandings(){
        print("load standings")
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        let standingsDatatask = URLSession.shared.dataTask(with: standingsURL, completionHandler: dataLoaded)
        
        standingsDatatask.resume()
    }
    
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let standingsDetailData = data{
            let decoder = JSONDecoder()
            do {
                let jsondata = try decoder.decode(Initial.self, from: standingsDetailData)
                var i = 0
                var j = 0
                standingData = jsondata.records!
                for _ in standingData{
                    for _ in standingData[i].teamRecords {
                        let teamName = standingData[i].teamRecords[j].team.name
                        let gP = standingData[i].teamRecords[j].gamesPlayed
                        let w = standingData[i].teamRecords[j].leagueRecord.wins
                        let l = standingData[i].teamRecords[j].leagueRecord.losses
                        let oT = standingData[i].teamRecords[j].leagueRecord.ot
                        let p = standingData[i].teamRecords[j].points
                        gamesPlayed.append(gP)
                        wins.append(w)
                        loses.append(l)
                        overTime.append(oT!)
                        points.append(p)
                        teams.append(teamName)
                        j+=1
                        if(j >= standingData[i].teamRecords.count) {
                            j = 0
                        }
                    }
                    i+=1
                }
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.activityIndicator.removeFromSuperview()
                }
            }catch let error{
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
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standingsCell", for: indexPath) as! standingsCell
        
        cell.teamImage.image = UIImage(named: teams[indexPath.row])
        cell.gamesPlayed.text = String(gamesPlayed[indexPath.row])
        cell.wins.text = String(wins[indexPath.row])
        cell.loses.text = String(loses[indexPath.row])
        cell.overTime.text = String(overTime[indexPath.row])
        cell.points.text = String(points[indexPath.row])

        
        return cell
    }

}
