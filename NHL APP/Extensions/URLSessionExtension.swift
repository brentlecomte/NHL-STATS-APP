//
//  URLSessionExtension.swift
//  NHL APP
//
//  Created by Brent Le Comte on 17/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

extension URLSession {
    func dataTask(with url: URL, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}
