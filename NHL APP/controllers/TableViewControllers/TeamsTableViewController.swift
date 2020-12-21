//
//  TeamsTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TeamsTableViewController: UITableViewController {
    
    var teamsURL:URL = URL(string: "https://statsapi.web.nhl.com/api/v1/teams")!
    var teamsData: [Teams] = []
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTeams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsData.count
    }
    
    func loadTeams(){
        print("load Teams")
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        let teamsDatatask = URLSession.shared.dataTask(with: teamsURL, completionHandler: dataLoaded)
        
        teamsDatatask.resume()
    }
    
    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do {
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                teamsData = jsondata.teams!
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

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! teamsCell
        
        cell.teamName.text = teamsData[indexPath.row].name
        cell.teamLogo.image = UIImage(named: teamsData[indexPath.row].name!)

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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! TeamsViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow
        detailVC.currentDetail = teamsData[(selectedIndexPath?.row)!]
        let selectedCell = tableView.cellForRow(at: selectedIndexPath!)
        detailVC.detailImage = selectedCell?.imageView?.image
    
    }
}
