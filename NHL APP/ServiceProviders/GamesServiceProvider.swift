//
//  GamesServiceProvider.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

protocol GamesServiceProvider {
    func fetchGamesSchedule(_ completion: @escaping ((Result<[Game], Error>) -> Void))
}

class NHLGamesServiceProvider: GamesServiceProvider {
    private let decoder = JSONDecoder()
    
    func fetchGamesSchedule(_ completion: @escaping ((Result<[Game], Error>) -> Void)) {
        // This url can be safely forced unwrapped as this is a valid URL
        let url = URL(string: "http://student.howest.be/brent.le.comte/20172018/native/shedule.json")!
        
        // The real endpoint but because the competion is stopped, this won't return any data.
        // private var todaysGamesURL: URL = URL(string: "https://statsapi.web.nhl.com/api/v1/schedule")!
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let jsondata = try self.decoder.decode(Initial.self, from: data)
                    if let dates = jsondata.dates, !dates.isEmpty {
                        completion(.success(dates[0].games))
                    }
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
