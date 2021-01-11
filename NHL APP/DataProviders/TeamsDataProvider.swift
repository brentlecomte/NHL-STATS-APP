//
//  TeamsDataProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/01/2021.
//  Copyright © 2021 Brent Le Comte. All rights reserved.
//

import Foundation

protocol TeamsDataProviderProtocol {
    func fetchTeams(_ completion: @escaping ((Result<[Teams], NHLServiceError>) -> Void))
}

class TeamsDataProvider: TeamsDataProviderProtocol {
    let serviceProvider: TeamsServiceProvider
    
    init(serviceProvider: TeamsServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchTeams(_ completion: @escaping ((Result<[Teams], NHLServiceError>) -> Void)) {
        serviceProvider.fetchTeams(completion)
    }
}
