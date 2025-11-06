//
//  RecipesView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI

struct RecipesView: View {
    
    @State var recipesList = []
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.base.ignoresSafeArea(edges: .top)
            VStack {
                if recipesList.isEmpty {
                    EmptyListView(listName: "recipes")
                }
            }
        }
    }
}

#Preview {
    RecipesView()
}
