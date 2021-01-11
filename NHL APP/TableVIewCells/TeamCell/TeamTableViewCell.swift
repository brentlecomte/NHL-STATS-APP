//
//  TeamsCell.swift
//  NHL APP
//
//  Created by Brent Le Comte on 07/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    @IBOutlet private var teamNameLabel: UILabel!
    @IBOutlet private var teamImage: UIImageView!
    
    static let reuseIdentifier = "TeamTableViewCell"
    static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    func configure(teamName: String?) {
        if let teamName = teamName {
            teamNameLabel.text = teamName
            teamImage.image = UIImage(named: teamName)
        }
    }
}
