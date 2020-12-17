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
    
    var gameTimer: Timer!
    
    //local file, for testing or when no games are being played or will be played today
    var todaysGamesURL: URL = URL(string: "http://student.howest.be/brent.le.comte/20172018/native/shedule.json")!
    
    //live API
//    var todaysGamesURL: URL = URL(string: "https://statsapi.web.nhl.com/api/v1/schedule")!
    var liveFeed = ""
    
    
    var gameData: [Game] = []
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    func addNavBarImage () {
        let navController = navigationController!
        
        let image = #imageLiteral(resourceName: "nhlLogo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth/2 - image.size.width/2
        let bannerY = bannerHeight/2 - image.size.height/2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addNavBarImage()
        loadTodaysGames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTodaysGames(){
        print("load Games")
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        let todaysGamesDatatask = URLSession.shared.dataTask(with: todaysGamesURL, completionHandler: dataLoaded)
        
        todaysGamesDatatask.resume()
    }
    
    func setupTableView() {
        tableView.register(TodaysGamesCell.nib, forCellReuseIdentifier: TodaysGamesCell.reuseIdentifier)
        loadViewIfNeeded()
        _ = self.view
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 239
        
    }
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do {
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                if (jsondata.dates?.count)! > 0 {
                gameData = jsondata.dates![0].games
                DispatchQueue.main.async{
                    
                    self.noGames.isHidden = true
                    self.noGamesimage.isHidden = true
                    self.tableView.reloadData()
                    self.activityIndicator.removeFromSuperview()
                }
                } else {
                    DispatchQueue.main.async{
                        self.tableView.isHidden = true
                        self.noGames.isHidden = false
                        self.noGamesimage.isHidden = false
                        self.activityIndicator.removeFromSuperview()
                    }
                }
            }catch let error{
               print(error)
            }
        }else{
            print(error!)
        }
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
        let date = gameData[indexPath.row].gameDate;
        
        let start = date.index(date.startIndex, offsetBy: 11)
        let end = date.index(date.endIndex, offsetBy: -4)
        let range = start..<end
        liveFeed = gameData[indexPath.row].link
        
        cell.configure(team: gameData[indexPath.row].teams, puckDrop: String(date[range]), venue: "@" + gameData[indexPath.row].venue.name, score: (1, 0))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let detailVC = segue.destination as! LiveFeedTableViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow
        detailVC.liveFeedLink = gameData[(selectedIndexPath?.row)!].link
        detailVC.homeTeam = (gameData[(selectedIndexPath?.row)!].teams.home.team?.name)!
        detailVC.awayTeam = (gameData[(selectedIndexPath?.row)!].teams.away.team?.name)!
    }


}
