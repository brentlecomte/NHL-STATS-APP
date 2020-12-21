//
//  PlayersTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 09/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    var teams:Teams?
    var roster: [Roster] = []
    var teamId: Int?
    var selectedId: Int = 0
    var baseURL = "https://statsapi.web.nhl.com/api/v1/teams/"
    var endURL = "/roster"
    var detailUrl: String = ""
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        selectedId = teamId!
        print(selectedId)
            let detailURL = URL(string: "\(baseURL)\(selectedId)\(endURL)")
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
                print(jsondata)
                roster = jsondata.roster!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.removeFromSuperview()
                }
                print(roster)
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roster.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.playerName.text = "#"+roster[indexPath.row].jerseyNumber! + " " + roster[indexPath.row].person.fullName
        cell.position.text = roster[indexPath.row].position?.name

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as! PlayerDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow
        detailVC.id = roster[(selectedIndexPath?.row)!].person.id
    }

}
