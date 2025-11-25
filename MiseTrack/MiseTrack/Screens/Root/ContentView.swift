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
    
    @State var sauces: [Sauce] = []
    @State var recipes: [Recipe] = []
    var body: some View {
        TabView {
            SaucesView()
                .tabItem {
                    Label("Sauces", systemImage: "drop.fill")
                }
            
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book.fill")
                }
        }
        .task {
            do {
                let recipeService = RecipeService()
                recipes = try await recipeService.getAllRecipes()
                print(recipes)
                
                let sauceService = SauceService()
                sauces = try await sauceService.getAllSauces()
                print(sauces)
            } catch {
                // Handle or log the error as needed
                print("Failed to load sauces: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
