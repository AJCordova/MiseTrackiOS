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
import ConfigService
import UIKit

struct ContentView: View {
    @EnvironmentObject var service: ServiceContainer    
    @State var showUpdatePrompt: Bool = false
    
    var body: some View {
        TabView {
            SauceListView(viewModel: service.makeSauceListViewModel())
                .tabItem {
                    Label("Sauces", systemImage: "drop.fill")
                }
            
            RecipeListView(viewModel: service.makeRecipeListViewModel())
                .tabItem {
                    Label("Recipes", systemImage: "book.fill")
                }
        }
        .alert("Update Required", isPresented: $showUpdatePrompt) {
            Button("Ok") {
                
            }
        } message: {
            Text("Please update to the latest version.")
        }
        .onAppear {
            let remoteVersionNumber = service.configService.getString(.remoteVersion)
            guard let appVersion = UIApplication.appVersion else {
                print("Error retrieving app version.")
               return
            }
            
            if appVersion != remoteVersionNumber {
                showUpdatePrompt = true
            }
        }
    }
}

#Preview {
    ContentView()
}
