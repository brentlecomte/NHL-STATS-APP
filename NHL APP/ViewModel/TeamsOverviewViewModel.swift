//
//  TeamsOverviewViewModel.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/01/2021.
//  Copyright © 2021 Brent Le Comte. All rights reserved.
//

import Foundation

class TeamsOverviewViewModel {
    var teamsDataProvider: TeamsDataProvider?
    
    init(teamsDataProvider: TeamsDataProvider?) {
        self.teamsDataProvider = teamsDataProvider
    }
    
    func loadTeams(_ completion: @escaping ((Result<[Teams], Error>) -> Void)) {
        teamsDataProvider?.fetchTeams() {  result in
            switch result {
            case .success(let teams):
                completion(.success(teams))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
