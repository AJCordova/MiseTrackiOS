//
//  ServiceContainer.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Foundation
import FirebaseCore
import ConfigService
import SauceServices
import RecipeServices

@MainActor
class ServiceContainer: ObservableObject {
    
    let configService: ConfigProviderProtocol
    let sauceService: SauceServicesProtocol
    let recipeService: RecipeServiceProtocol
    
    init() {
        FirebaseApp.configure()
        self.configService = ConfigService.shared.initConfigService()
        self.sauceService = SauceService()
        self.recipeService = RecipeService()
        self.loadConfiguration()
    }
    
    private func loadConfiguration() {
        Task {
            do {
                try await configService.fetchConfig()
            } catch {
                print("Fetching remote config failed. Using default settings.")
            }
        }
    }
    
    func makeRecipeListViewModel() -> RecipeListViewModel {
        return RecipeListViewModel(recipeService: recipeService, configService: configService)
    }
    
    func makeSauceListViewModel() -> SauceListViewModel {
        return SauceListViewModel(sauceService: sauceService, configService: configService)
    }
}
