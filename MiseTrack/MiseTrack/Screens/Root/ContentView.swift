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
    private let sauceService: SauceServicesProtocol
    private let recipeService: RecipeServiceProtocol
    
    @State var showUpdatePrompt: Bool = false
    
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
