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
            ContentView(isAllData: true).tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            ContentView().tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
        }
    }
}

#Preview {
    MainApp()
}
