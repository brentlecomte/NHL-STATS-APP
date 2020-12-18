//
//  GamesDataProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

protocol GamesDataProviderProtocol {
    func fetchSchedule(_ completion: @escaping ((Result<[Game], NHLServiceError>) -> Void))
    func fetchLiveFeed(liveFeedLink: String, _ completion: @escaping ((Result<Plays, NHLServiceError>) -> Void))
}

class GamesDataProvider: GamesDataProviderProtocol {
    let serviceProvider: GamesServiceProvider
    
    init(serviceProvider: GamesServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchSchedule(_ completion: @escaping ((Result<[Game], NHLServiceError>) -> Void)) {
        serviceProvider.fetchGamesSchedule(completion)
    }
    
    func fetchLiveFeed(liveFeedLink: String, _ completion: @escaping ((Result<Plays, NHLServiceError>) -> Void)) {
        serviceProvider.fetchLiveGameUpdates(liveFeedLink: liveFeedLink, completion)
    }
}
