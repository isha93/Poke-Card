//
//  TeamsViewModel.swift
//  Poke-Card
//
//  Created by Wildan on 28/05/24.
//

import Foundation

@MainActor
class TeamsViewModel: ObservableObject {
    @Published var teams: TeamsModelData = []
    
    private let teamsServices: TeamsServicesProtocol
    
    init(teamsServices: TeamsServicesProtocol = TeamsServices(networker: Networker())) {
        self.teamsServices = teamsServices
    }
}

extension TeamsViewModel {
    func getTeams() async{
        do{
            let teamsFetchApi = try await teamsServices.getTeams(endPoint: .getTeams)
            self.teams = teamsFetchApi
            print("jalan")
        }catch{
            print(error.localizedDescription)
        }
    }
}
