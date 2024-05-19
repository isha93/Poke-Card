//
//  DetailHeroView.swift
//  Poke-Card
//
//  Created by Wildan on 12/05/24.
//

import SwiftUI

struct DetailHeroView: View {
    var hero: DotaHeroesModelData?
    
    var body: some View {
        VStack {
            Text(hero?.localizedName ?? "")
        }
    }
}
