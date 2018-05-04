//
//  datamodel.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import Foundation

struct Initial: Codable {
    let copyright: String
    let totalItems: Int
    let totalEvents: Int
    let totalGames: Int
    let totalMatches: Int
    let wait: Int
    let dates: [Dates]
}


struct Dates: Codable {
    let date: String
    let totalItems: Int
    let totalEvents: Int
    let totalGames: Int
    let totalMatches: Int
    let games: [Game]
}

struct Game: Codable {
    let gamePk: Int
    let link: String
    let gameType: String
    let season: String
    let gameDate: String
    let status: Status
    let teams: Team
    let venue: Venue
    let content: Content
}

struct Status: Codable {
    let abstractGameState: String
    let codedGameState: Int
    let detailedState: String
    let statusCode: Int
    let startTimeTBD: Bool
}

struct Team: Codable {
    let away: Away
    let home: Home
}

struct Away: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
    let team: TeamInfo
}

struct Home: Codable {
    let leagueRecord: LeagueRecord
    let score: Int
    let team: TeamInfo
}

struct LeagueRecord: Codable {
    let wins: Int
    let losses: Int
    let type: String
}

struct TeamInfo: Codable {
    let id: Int
    let name: String
    let link: String
}

struct Venue: Codable {
    let name: String
    let link: String
}

struct Content: Codable {
    let link: String
}
