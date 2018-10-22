//
//  todaysGamesCell.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class todaysGamesCell: UITableViewCell {

    @IBOutlet weak var homeAfbeelding: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    
    @IBOutlet weak var awayAfbeelding: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    
    @IBOutlet weak var puckDrop: UILabel!
    @IBOutlet weak var venue: UILabel!
    
    @IBOutlet weak var noGames: UILabel!
}
