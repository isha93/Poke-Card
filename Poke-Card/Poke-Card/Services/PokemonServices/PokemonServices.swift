//
//  PokemonServices.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/04/07.
//

import Foundation

// protocol is blueprient of function/variable, jadi kelas yang menjalankan harus mengisi kontrak yang ada di dalam protocol
// goals of using protocol for mock testing

protocol PokemonServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getPokemon(endPoint: NetworkFactory) async throws -> PokemonModelData
}

class PokemonServices: PokemonServicesProtocol {
    
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol) {
        self.networker = networker
    }
    
    func getPokemon(endPoint: NetworkFactory) async throws -> PokemonModelData {
        return try await networker.taskAsync(type: PokemonModelData.self, endPoint: endPoint, isMultipart: false)
    }
}
