//
//  Bootstrap.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

struct Bootstrap {
    static func datalayer() {
        // serviceProviders
        let gamesServiceProvider = NHLGamesServiceProvider()
        
        // dataProviders
        let gamesDataProvider = GamesDataProvider(serviceProvider: gamesServiceProvider)
        
        ViewControllerProvider.sharedInstance.dataProviders = DataProviders.init(gamesDataProvider: gamesDataProvider)
    }
}