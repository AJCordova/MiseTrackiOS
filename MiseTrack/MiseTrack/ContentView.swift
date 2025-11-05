//
//  ContentView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI

struct ContentView: View {
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
        .onAppear() {
            let standardAppearance = UITabBarAppearance()
            standardAppearance.shadowColor = UIColor(Color.divider)
            UITabBar.appearance().standardAppearance.shadowColor = UIColor(Color.divider)
        }
        
    }
}

#Preview {
    ContentView()
}
