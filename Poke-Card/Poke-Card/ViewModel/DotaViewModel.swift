//
//  DotaViewModel.swift
//  Poke-Card
//
//  Created by Wildan on 11/05/24.
//

import Foundation

@MainActor
class DotaViewModel: ObservableObject {
    @Published var dotas: [DotaHeroesModelData] = []
    @Published var primaries: Set<String> = []
    
    private let dotaServices: DotaServicesProtocol
    
    init(dotaServices: DotaServicesProtocol = DotaServices(networker: Networker())) {
        self.dotaServices = dotaServices
    }
    
    func getAllPrimary() {
        for dota in dotas {
            if let primaryAttr = dota.primaryAttr?.rawValue {
                primaries.insert(primaryAttr)
            }
        }
        primaries.insert("reset")
    }
    
    func getDota(name: String) async {
        do {
            let dota = try await dotaServices.getDotas(endPoint: .getPokemon(name: name))
            self.dotas = dota
            
            getAllPrimary()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
