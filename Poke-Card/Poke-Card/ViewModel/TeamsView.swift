//
//  TeamsView.swift
//  Poke-Card
//
//  Created by Wildan on 28/05/24.
//

import SwiftUI

struct TeamsView: View {
    @StateObject var teamsViewModel = TeamsViewModel()
    
    
    
    var body: some View {
        VStack {
            Text("fjjf")
            ScrollView{
                ForEach(teamsViewModel.teams, id: \.teamID){ team in
                    Text(team.name!)
                }
            }
        }.onAppear(){
            Task {
                await teamsViewModel.getTeams()
                print("hasil \(teamsViewModel.teams)")
            }
        }
    }
}

#Preview {
    TeamsView()
}
