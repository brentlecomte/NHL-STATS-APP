//
//  datamodel.swift
//  NHL APP
//
//  Created by Brent Le Comte on 02/05/2018.
//  Copyright © 2018 Brent Le Comte. All rights reserved.
//

import Foundation

//Schedule

struct Initial: Codable {
    let totalGames: Int?
    let dates: [Dates]?
    let teams: [Teams]?
    let records: [Records]?
    let roster: [Roster]?
    let gameData: GameData?
    let liveData: LiveData?
    let people: [People]?
    let stats: [Stats]?
}


struct Dates: Codable {
    let date: String?
    let totalGames: Int
    let games: [Game]
}

struct Game: Codable {
    let link: String
    let gameDate: String
    let status: Status
    let teams: Team
    let venue: Venue
    let content: Content
    
    func dateRange() -> String {
        let start = gameDate.index(gameDate.startIndex, offsetBy: 11)
        let end = gameDate.index(gameDate.endIndex, offsetBy: -4)
        return String(describing: start..<end)
    }
}

struct Status: Codable {
    let abstractGameState: String
    let codedGameState: String
    let detailedState: String
    let statusCode: String
    let startTimeTBD: Bool
}

struct Team: Codable {
    let away: Away
    let home: Home
}

struct Away: Codable {
    let team: TeamInfo?
    let name: String?
}

struct Home: Codable {
    let team: TeamInfo?
    let name: String?
}

struct LeagueRecord: Codable {
    let wins: Int
    let losses: Int
    let type: String
    let ot: Int?
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

//teams

struct Teams: Codable {
    let id: Int?
    let name: String?
    let link: String?
    let abbreviation: String?
    let teamName: String?
    let locationName: String?
    let firstYearOfPlay: String?
    let officialSiteUrl: String?
    let franchiseId: Int?
    let venue: Venue?
    let division: Division?
    let conference: Conference?
    let franchise: Franchise?
    let Away: Away?
    let Home: Home?
    
}

struct Division: Codable {
    let id: Int
    let name: String
    let link: String
}

struct Conference: Codable {
    let id: Int
    let name: String
    let link: String
}

struct Franchise: Codable {
    let franchiseId: Int
    let link: String
}


//standings

struct Records: Codable {
    let division: Division
    let conference: Conference
    let teamRecords: [TeamRecords]
}

struct TeamRecords: Codable {
    let team: TeamInfo
    let leagueRecord: LeagueRecord
    let points: Int
    let gamesPlayed: Int
}

struct Standings: Codable {
    let teamRecords: [TeamRecords]
}

//roster

struct Roster: Codable {
    let person: Person
    let jerseyNumber: String?
    let position: Position?
}

struct Person: Codable {
    let id: Int
    let fullName: String
    let link: String
}

struct Position: Codable {
    let name: String?
    let type: String?
    let abbreviation: String?
}

//live

struct GameData: Codable {
    let teams: Teams
}

struct LiveData: Codable {
    let plays: Plays
}

struct Plays: Codable {
    let allPlays: [AllPlays]
    let currentPlay: CurrentPlay
}

struct AllPlays: Codable {
    let players: [Players]?
    let result: Event
    let about: About?
    let coordinates: Coordinates?
    let team: TeamInfo?
}

struct CurrentPlay: Codable {
    let result: Event
    let about: About
    let coordinates: Coordinates
}

struct Players: Codable {
    let player: Person
    let playerType: String?
}

struct Event: Codable {
    let event: String
    let description: String
    let secondaryType: String?
}

struct About: Codable {
    let period: Int
    let periodTime: String
    let periodTimeRemaining: String
    let goals: Goals
}

struct Goals: Codable {
   let away: Int
   let home: Int
}

struct Coordinates: Codable {
    let x: Int?
    let y: Int?
}


//Players

struct People: Codable {
    let fullName: String
    let firstName: String
    let lastName: String
    let primaryNumber: String
    let currentAge: Int
    let birthCountry: String
    let height: String
    let active: Bool
    let rookie: Bool
    let currentTeam: CurrentTeam
    let primaryPosition: PrimaryPosition
}

struct CurrentTeam: Codable {
    let name: String
}

struct PrimaryPosition: Codable {
    let name: String
}

//stats

struct Stats: Codable {
    let splits: [Splits]
}

struct Splits: Codable {
    let stat: Stat
}

struct Stat: Codable {
    let gamesPlayed: Int
    let wins: Int
    let losses: Int
    let ot: Int
    let pts: Int
    let ptPctg: String
    let goalsPerGame: Float
    let goalsAgainstPerGame: Float
    let evGGARatio: Float
    let powerPlayPercentage: String
    let powerPlayGoals: Int
    let powerPlayGoalsAgainst: Int
    let powerPlayOpportunities: Int
    let penaltyKillPercentage: String
    let shotsPerGame: Float
    let shotsAllowed: Float
    let winScoreFirst: Float
    let winOppScoreFirst: Float
    let winLeadFirstPer: Float
    let winLeadSecondPer: Float
    let winOutshootOpp: Float
    let winOutshotByOpp: Float
    let faceOffsTaken: Int
    let faceOffsWon: Int
    let faceOffsLost: Int
    let faceOffWinPercentage: String
    let shootingPctg: Float
    let savePctg: Float
}
