//
//  PokemonViewModel.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/04/07.
//

import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    // MARK: data model of pokemon it will emit to view
    @Published var pokemon: PokemonModelData?
    
    private let pokemonServices: PokemonServicesProtocol
    
    init(pokemonServices: PokemonServicesProtocol = PokemonServices(networker: Networker())) {
        self.pokemonServices = pokemonServices
    }

    func getPokemon(name: String) async {
        do {
            let pokemon = try await pokemonServices.getPokemon(endPoint: .getPokemon(name: name))
            self.pokemon = pokemon
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAbility(name: String) async {
        do {
            let ability = try await pokemonServices.getPokemon(endPoint: .getAbility(name: name))
            print(ability)
        } catch {
            print(error.localizedDescription)
        }
    }
}
