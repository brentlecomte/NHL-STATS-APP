//
//  TodaysGamesTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TodaysGamesTableViewController: UITableViewController {
    
    
    
    var todaysGamesURL: URL = URL(string: "https://statsapi.web.nhl.com/api/v1/schedule")!
    
    var gameData: [Dates] = []
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            print("detaildata", detailData)
            let decoder = JSONDecoder()
            do {
                let jsondata = try decoder.decode([Dates].self, from: detailData)
                gameData = jsondata //Hier .instantie wil doen krijg ik ook een error
               
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }catch let error{
                print(error)
            }
        }else{
            print(error!)
        }
        
    }
    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        let decoder = JSONDecoder()
//        do {
//            let dates = try decoder.decode([String: Dates].self, from: data)
//            print(dates)
//            if let game = dates["Game"] {
//                gameData = game.games
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.activityIndicator.removeFromSuperview()
//                }
//            }
//        } catch let error {
//            print(error)
//            //opnieuw proberen
//            DispatchQueue.main.async {
//                self.loadTodaysGames()
//            }
//
//        }
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todaysGamesCell", for: indexPath) as! todaysGamesCell
        
//        cell.homeTeamName?.text = gameData[indexPath.row].games.teams.home.team
//        cell.awayTeamName?.text = gameData[indexPath.row].teams.away.team.name
//        cell.puckDrop?.text = gameData[indexPath.row].gameDate
//        cell.venue?.text = gameData[indexPath.row].venue.name
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
