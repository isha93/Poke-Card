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
    
    private let dotaServices: DotaServicesProtocol
    
    init(dotaServices: DotaServicesProtocol = DotaServices(networker: Networker())) {
        self.dotaServices = dotaServices
    }
    
    func getDota(name: String) async {
        do {
            let dota = try await dotaServices.getDotas(endPoint: .getPokemon(name: name))
            self.dotas = dota
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
