//
//  DotaServices.swift
//  Poke-Card
//
//  Created by Wildan on 11/05/24.
//

import Foundation

protocol DotaServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getDotas(endPoint: NetworkFactory) async throws -> [DotaHeroesModelData]
}

class DotaServices: DotaServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol) {
        self.networker = networker
    }
    
    func getDotas(endPoint: NetworkFactory) async throws -> [DotaHeroesModelData] {
        return try await networker.taskAsync(type: [DotaHeroesModelData].self, endPoint: endPoint, isMultipart: false)
    }
}
