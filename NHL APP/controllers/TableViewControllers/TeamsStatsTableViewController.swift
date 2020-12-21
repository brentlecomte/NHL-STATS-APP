//
//  TeamsStatsTableViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TeamsStatsTableViewController: UITableViewController {
    
    var teamId: Int = 0
    var baseURL = "https://statsapi.web.nhl.com/api/v1/teams/"
    var endURL = "/stats"
    var statsData: [Stats] = []

    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detailURL = URL(string: "\(baseURL)\(teamId)\(endURL)")!
        print(detailURL)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        let task = URLSession.shared.dataTask(with: detailURL, completionHandler: dataLoaded)
        task.resume()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataLoaded(data:Data?,response:URLResponse?,error:Error?){
        if let detailData = data{
            let decoder = JSONDecoder()
            do{
                let jsondata = try decoder.decode(Initial.self, from: detailData)
                statsData = jsondata.stats!
                print(statsData)
                DispatchQueue.main.async {
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! StatsCell
        
        cell.title.text = "yeet"

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
