//
//  GamesDataProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

protocol GamesDataProviderProtocol {
    func fetchSchedule(_ completion: @escaping ((Result<[Game], Error>) -> Void))
}

class GamesDataProvider: GamesDataProviderProtocol {
    let serviceProvider: GamesServiceProvider
    
    init(serviceProvider: GamesServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchSchedule(_ completion: @escaping ((Result<[Game], Error>) -> Void)) {
        serviceProvider.fetchGamesSchedule { result in
            switch result {
            case .success(let schedule):
                completion(.success(schedule))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
