//
//  TodaysGamesCell.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class TodaysGamesCell: UITableViewCell {
    @IBOutlet private var puckDropLabel: UILabel!
    @IBOutlet private var venueLabel: UILabel!
    
    @IBOutlet private var awayTeamImageView: UIImageView!
    @IBOutlet private var awayTeamTeamNameLabel: UILabel!
    @IBOutlet private var awayTeamScoreLabel: UILabel!
    
    @IBOutlet private var homeTeamImageView: UIImageView!
    @IBOutlet private var homeTeamTeamNameLabel: UILabel!
    @IBOutlet private var homeTeamScoreLabel: UILabel!
    
    static let reuseIdentifier = "TodaysGamesCell"
    static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(team: Team, puckDrop: String, venue: String) {
        if let awayTeam = team.away.team?.name,
           let homeTeam = team.home.team?.name,
           let awayScore = team.away.score,
           let homeScore = team.home.score {
            awayTeamImageView.image = UIImage(named: awayTeam)
            awayTeamTeamNameLabel.text = awayTeam
            awayTeamScoreLabel.text = String(awayScore)
            
            homeTeamImageView.image = UIImage(named: homeTeam)
            homeTeamTeamNameLabel.text = homeTeam
            homeTeamScoreLabel.text = String(homeScore)
        }
        
        self.puckDropLabel.text = puckDrop
        self.venueLabel.text = venue
    }
}
