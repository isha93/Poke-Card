//
//  ContentView.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    var isAllData: Bool = false
    
    @StateObject var heroesViewModel = DotaViewModel()
    @State var navigateTo: Bool = false
    @State var destinationView: AnyView = AnyView(EmptyView())
    @State var namePokemon: String = ""
    @State var primarySelect = ""
    
    var listHerosByPrimary: [DotaHeroesModelData] {
        if primarySelect.isEmpty {
            return heroesViewModel.dotas
        }else{
            return heroesViewModel.dotas.filter {
                $0.primaryAttr?.rawValue == primarySelect
            }
        }
    }
    
    var body: some View {
        VStack{
            if(heroesViewModel.isLoading){
                Spacer()
                
                ProgressView{
                    Text("Loading...").font(.title2)
                }
                
                Spacer()
            }else{
                ScrollView{
                    // isAllData = true
                    if !(isAllData) {
                        Picker("Select", selection: $primarySelect) {
                            ForEach(Array(heroesViewModel.primaries), id:\.self) {
                                hero in
                                Text(hero)
                            }
                        }.pickerStyle(.segmented).padding(.bottom)
                    }
                    
                    NavigationLink(destination: destinationView, isActive: $navigateTo , label: { EmptyView() })
                    ForEach(listHerosByPrimary, id: \.id){ dota in
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
                        //                For unknown error when tap for hstack
                        .contentShape(Rectangle())
                        
                        .onTapGesture {
                            navigateTo = true
                            destinationView = AnyView(DetailHeroView(hero: dota))
                        }
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
