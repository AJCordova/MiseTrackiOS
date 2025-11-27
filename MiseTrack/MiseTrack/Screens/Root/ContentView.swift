//
//  ContentView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import Foundation
import SwiftUI
import Models
import SauceServices
import RecipeServices

struct ContentView: View {
    private let sauceService: SauceServicesProtocol
    private let recipeService: RecipeServiceProtocol
    
    public init(sauceService: SauceServicesProtocol = SauceService(),
                recipeService: RecipeServiceProtocol = RecipeService()) {
        self.sauceService = sauceService
        self.recipeService = recipeService
    }
    
    var body: some View {
        TabView {
            SauceListView(sauceService: sauceService, recipeService: recipeService)
                .tabItem {
                    Label("Sauces", systemImage: "drop.fill")
                }
            
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book.fill")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
