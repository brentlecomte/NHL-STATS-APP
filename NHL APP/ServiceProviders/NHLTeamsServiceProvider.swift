//
//  NHLTeamsServiceProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 11/01/2021.
//  Copyright © 2021 Brent Le Comte. All rights reserved.
//

import Foundation

protocol TeamsServiceProvider {
    func fetchTeams(_ completion: @escaping ((Result<[Teams], NHLServiceError>) -> Void))
}

class NHLTeamsServiceProvider: TeamsServiceProvider {
    private let decoder = JSONDecoder()
    
    func fetchTeams(_ completion: @escaping ((Result<[Teams], NHLServiceError>) -> Void)) {
        guard let url = URL(string: "\(endPoints.baseURL.rawValue)\(endPoints.v1.rawValue)\(endPoints.teams.rawValue)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let jsondata = try self.decoder.decode(Initial.self, from: data)
                    if let teams = jsondata.teams, !data.isEmpty {
                        completion(.success(teams))
                        return
                    }
                    throw NHLServiceError.invalidData
                } catch _ {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
