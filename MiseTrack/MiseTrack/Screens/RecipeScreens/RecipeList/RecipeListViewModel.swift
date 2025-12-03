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
    @Published var showError = false
    
    var errorMessage: String? = nil
    
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
            self.presentThrownError(error)
        }
    }
    
    func isEditingEnabled() -> Bool {
        return configService.getBool(.allowRecipeEdit)
    }
    
    private func presentThrownError(_ error: Error) {
        self.isLoading = false
        self.errorMessage = error.localizedDescription
        self.showError = true
    }
}

