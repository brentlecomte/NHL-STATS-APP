//
//  LiveFeedViewModel.swift
//  NHL APP
//
//  Created by Brent Le Comte on 18/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

final class LiveFeedViewModel {
    private var gamesDataProvider: GamesDataProvider?
    private var liveFeedLink = ""
    
    init(gamesDataProvider: GamesDataProvider?, liveFeedLink: String) {
        self.gamesDataProvider = gamesDataProvider
        self.liveFeedLink = liveFeedLink
    }
    
    func getLiveFeed(_ completion: @escaping ((Result<[AllPlays], NHLServiceError>) -> Void)) {
        gamesDataProvider?.fetchLiveFeed(liveFeedLink: liveFeedLink, { result in
            switch result {
            case.success(let feed):
                completion(.success(feed.allPlays))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
