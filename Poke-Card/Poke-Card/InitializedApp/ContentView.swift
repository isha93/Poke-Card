//
//  ContentView.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var heroesViewModel = DotaViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(heroesViewModel.dotas, id: \.id){ dota in
                    HStack{
                        VStack{
                            Text(dota.localizedName ?? "").font(.headline).foregroundStyle(.red)
                            
                            ForEach(dota.roles ?? [], id:\.self) { role in
                                Text(role)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            Text(dota.attackType?.rawValue ?? "").font(.title3).foregroundStyle(.brown)
                        }
                        Spacer()
                        VStack{
                            Text(dota.primaryAttr?.rawValue ?? "").font(.headline).foregroundStyle(.orange)
                            Text("\(dota.legs ?? 0) \(dota.legs ?? 0 > 1 ? "legs" : "leg")")
                        }
                    }
                    .padding()
                    .overlay {
                        Rectangle().stroke(lineWidth: 2)
                    }
                }
            }
        }
        .onAppear(){
            Task {
                await heroesViewModel.getDota(name:"")
            }
        }
    }
}

#Preview {
    ContentView()
}
