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
        VStack {
            TabView {
                Tab("Sauces", systemImage: "list.star") {
                    SaucesView()
                }
                Tab("Recipes", systemImage: "book.pages") {
                    RecipesView()
                }
            }
        }
        //Test
        .onAppear() {
            let standardAppearance = UITabBarAppearance()
            standardAppearance.shadowColor = UIColor(Color.divider)
            UITabBar.appearance().standardAppearance = standardAppearance
        }
        .task {
            do {
                let service = RecipeService()
                recipes = try await service.getAllRecipes()
                print(recipes)
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
