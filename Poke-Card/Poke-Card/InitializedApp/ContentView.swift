//
//  ContentView.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokemonViewModel = PokemonViewModel()
    @State var namePokemon: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(pokemonViewModel.pokemon?.name ?? "")
            TextField("", text: $namePokemon)
                .textFieldStyle(.roundedBorder)
            if let pokemonAbilities = pokemonViewModel.pokemon?.abilities {
                ForEach(pokemonAbilities, id: \.slot) { ability in
                    Text(ability.ability?.name?.lowercased() ?? "")
                }
            }
            
            Button(role: .destructive) {
                Task {
                    try await pokemonViewModel.getPokemon(name:namePokemon)
                }
            } label: {
                Text("Search")
            }
        }
        .padding()
        .onAppear {
            
        }
    }
}

#Preview {
    ContentView()
}
