//
//  NHLServiceError.swift
//  NHL APP
//
//  Created by Brent Le Comte on 18/12/2020.
//  Copyright © 2020 Brent Le Comte. All rights reserved.
//

import Foundation

enum NHLServiceError: Error {
    case invalidURL
    case invalidData
    case general(Error)
}
