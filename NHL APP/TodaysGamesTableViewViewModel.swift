//
//  TodaysGamesTableViewViewModel.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

final class TodaysGamesTableViewViewmodel {

    private var gamesDataProvider: GamesDataProvider?
    
    init(gamesDataProvider: GamesDataProvider?) {
        self.gamesDataProvider = gamesDataProvider
    }
    
    func loadSchedule(_ completion: @escaping ((Result<[Game], Error>) -> Void)) {
        gamesDataProvider?.fetchSchedule() {  result in
            switch result {
            case .success(let schedule):
                completion(.success(schedule))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
