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

struct ContentView: View {
    
    @State var sauces: [Sauce] = []
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
                let service = SauceService()
                sauces = try await service.getAllSauces()
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
