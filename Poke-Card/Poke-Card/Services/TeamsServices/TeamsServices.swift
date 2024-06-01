//
//  TeamsService.swift
//  Poke-Card
//
//  Created by Wildan on 28/05/24.
//

import Foundation

protocol TeamsServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getTeams(endPoint: NetworkFactory)  async throws -> TeamsModelData
}

class TeamsServices: TeamsServicesProtocol {
    
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol) {
        self.networker = networker
    }
    
    func getTeams(endPoint: NetworkFactory) async throws -> TeamsModelData {
        return try await networker.taskAsync(type: TeamsModelData.self, endPoint: endPoint, isMultipart: false)
    }
    
}


//    .self -> search key is about generic line 24
