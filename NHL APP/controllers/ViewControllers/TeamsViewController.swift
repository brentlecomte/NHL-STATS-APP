//
//  detailGamesViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit
import CoreGraphics

class TeamsViewController: UIViewController {
    
    var teams:Teams?
    var baseURL = "https://statsapi.web.nhl.com"
    var detailImage:UIImage?
    
    @IBOutlet weak var TeamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var homeTown: UILabel!
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var conference: UILabel!
    @IBOutlet weak var division: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var currentDetail: Teams? {
        didSet{
            showInfoDetail()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let chosenTeam = teams{
            let detailURL = URL(string: "\(baseURL)\(String(describing: chosenTeam.link))")
            view.addSubview(activityIndicator)
            activityIndicator.frame = view.bounds
            activityIndicator.startAnimating()
            
            let task = URLSession.shared.dataTask(with: detailURL!, completionHandler: dataLoaded)
            task.resume()
        }
        
    }
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do{
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                print(jsondata)
                currentDetail = jsondata.teams?[0]

            }catch let error{
                print(error)
            }
        }else{
            print(error!)
        }
    }
    
    func showInfoDetail(){
        if let detail = currentDetail{
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.TeamImage.image = UIImage(named: detail.name!)
                self.teamName.text = detail.name
                self.homeTown.text = detail.locationName
                self.stadium.text = detail.venue?.name
                self.conference.text = detail.conference?.name
                self.division.text = detail.division?.name
                self.navigationItem.title = detail.name
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! PlayersTableViewController
        detailVC.teamId = (currentDetail?.id)!
    }
}


