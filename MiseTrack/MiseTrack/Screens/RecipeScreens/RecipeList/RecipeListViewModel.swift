//
//  RecipeListViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 27/11/2025.
//

import Foundation
import Models
import RecipeServices
import ConfigService

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let recipeService: RecipeServiceProtocol
    private let configService: ConfigProviderProtocol
    
    public init(recipeService: RecipeServiceProtocol, configService: ConfigProviderProtocol) {
        self.recipeService = recipeService
        self.configService = configService
    }
    
    func loadRecipes() async {
        self.isLoading = true
        
        do {
            let retrievedRecipes = try await self.recipeService.getAllRecipes()
            self.recipes = retrievedRecipes
            self.isLoading = false
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func isEditingEnabled() -> Bool {
        return configService.getBool(.allowRecipeEdit)
    }
}

