//
//  LiveFeedDetailTeamView.swift
//  NHL APP
//
//  Created by Brent Le Comte on 18/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation
import UIKit

class LiveFeedDetailTeamView: UIView {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var teamNameLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!
        
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LiveFeedDetailTeamView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(team: Team?, currentPlay: CurrentPlay?, type: TeamEnum) {
        switch type {
        case .away:
            setUpView(team: team?.away.team?.name, score: currentPlay?.about.goals.away)
        case .home:
            setUpView(team: team?.home.team?.name, score: currentPlay?.about.goals.home)
        }
    }
    
    private func setUpView(team: String?, score: Int?) {
        imageView.image = UIImage(named: team ?? "AppIcon")
        teamNameLabel.text = team
        scoreLabel.text = String(score ?? 0)
    }
}
