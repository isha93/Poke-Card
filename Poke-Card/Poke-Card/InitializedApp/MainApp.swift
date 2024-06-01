//
//  MainApp.swift
//  Poke-Card
//
//  Created by Wildan on 23/05/24.
//

import SwiftUI

struct MainApp: View {
    var body: some View {
        TabView {
          
            ContentView().tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            
            TeamsView().tabItem {
                Image(systemName: "person.3")
                Text("Teams")
            }
        }
    }
}

#Preview {
    MainApp()
}
