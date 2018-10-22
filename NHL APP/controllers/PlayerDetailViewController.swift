//
//  PlayerDetailViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    var playerData: [People] = []
    var player: Person?
    
    var id: Int = 0
    var baseURL = "https://statsapi.web.nhl.com/api/v1/people/"
    var endURL = "/stats"

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var jerseyNumber: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var waight: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var active: UILabel!
    @IBOutlet weak var captain: UILabel!
    @IBOutlet weak var rookie: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var currentDetail: People?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let detailURL = URL(string: "\(baseURL)\(id)\(endURL)")
            print(detailURL!)
            view.addSubview(activityIndicator)
            activityIndicator.frame = view.bounds
            activityIndicator.startAnimating()
            
            let task = URLSession.shared.dataTask(with: detailURL!, completionHandler: dataLoaded)
            task.resume()
    }
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do{
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                playerData = [jsondata.people![0]]
                DispatchQueue.main.async {
                    self.activityIndicator.removeFromSuperview()
                    self.showDetail()
                }
            }catch let error{
                print(error)
            }
        }else{
            print(error!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDetail(){
        if let detail = currentDetail{
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.playerName.text = detail.fullName
//                self.teamName.text = detail.name
//                self.homeTown.text = detail.locationName
//                self.stadium.text = detail.venue?.name
//                self.conference.text = detail.conference?.name
//                self.division.text = detail.division?.name
//                self.navigationItem.title = detail.name
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
