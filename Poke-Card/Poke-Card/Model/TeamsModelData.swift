//
//  TeamsModelData.swift
//  Poke-Card
//
//  Created by Wildan on 28/05/24.
//

import Foundation

struct TeamsModelDatum: Codable {
    let teamID, wins, losses: Int?
    let rating: Double?
    let lastMatchTime: Int?
    let name, tag: String?

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case rating, wins, losses
        case lastMatchTime = "last_match_time"
        case name, tag
    }
}

typealias TeamsModelData = [TeamsModelDatum]
