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
    @Published var isLoading: Bool = false
    
    private let dotaServices: DotaServicesProtocol
    
    init(dotaServices: DotaServicesProtocol = DotaServices(networker: Networker())) {
        self.dotaServices = dotaServices
    }    
}

// MARK: fetchAll Primary
extension DotaViewModel {
    func getAllPrimary() {
        for dota in dotas {
            if let primaryAttr = dota.primaryAttr?.rawValue {
                primaries.insert(primaryAttr)
            }
        }
    }
}

// MARK: fetchDota
extension DotaViewModel {
    func getDota(name: String) async {
        do {
            isLoading = true
            let dota = try await dotaServices.getDotas(endPoint: .getPokemon(name: name))
            self.dotas = dota
            
            getAllPrimary()
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
}
