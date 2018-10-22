//
//  FeedDetailViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    @IBOutlet weak var descriptionFeed: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    var x: Int = 0
    var y: Int = 0
    var descriptionDetail: String = ""
    var teamName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInfo() {
        
        let imageX = 161 - y
        let imageY = 344 - x
        self.descriptionFeed.text = descriptionDetail
        teamImage.frame = CGRect(x: imageX, y: imageY, width: 56, height: 56)
        teamImage.image = UIImage(named: teamName)
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
