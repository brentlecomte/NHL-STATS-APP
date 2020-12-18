//
//  LiveFeedTableViewCell.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit

class LiveFeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LiveFeedTableViewCell"
    static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    @IBOutlet private var teamImage: UIImageView!
    @IBOutlet private var event: UILabel!
    @IBOutlet private var time: UILabel!
    @IBOutlet private var descriptionAction: UILabel!
    
    func configure(team: TeamInfo?, event: Event, time: About?) {
        self.event.text = event.event
        teamImage.image = UIImage(named: team?.name ?? "AppIcon")
        self.time.text = time?.periodTime
        descriptionAction.text = event.description
    }
    
}
