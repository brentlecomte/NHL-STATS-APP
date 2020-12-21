//
//  FeedDetailViewController.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    static let storyBoardID = "FeedDetailViewController"
    
    @IBOutlet private var descriptionFeed: UILabel!
    @IBOutlet private var rinkImage: UIImageView!
    
    private let imageWidth = 56
    
    var play: AllPlays?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setInfo()
    }
    
    private func setInfo() {
        guard let play = play else { return }
        self.descriptionFeed.text = play.result.description
        setImage(play: play)

    }
    
    private func setImage(play: AllPlays) {
        let centerCoordinate = rinkImage.center
        let imageX: Int = Int(centerCoordinate.x) - (imageWidth/2) - (play.coordinates?.x ?? 0)
        let imageY: Int = Int(centerCoordinate.y) - Int(rinkImage.frame.minY) - (play.coordinates?.x ?? 0)
        let teamImage = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageWidth, height: imageWidth))
        
        teamImage.image = UIImage(named: play.team?.name ?? "AppIcon")
        
        view.addSubview(teamImage)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false

        navigationItem.title = "detail"
        navigationItem.leftItemsSupplementBackButton = true
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonAction))
        
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
