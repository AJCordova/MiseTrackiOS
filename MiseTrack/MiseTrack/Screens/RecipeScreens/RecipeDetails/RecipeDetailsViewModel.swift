//
//  RecipeDetailsViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

import Foundation
import RecipeServices
import ConfigService
import Models

@MainActor
class RecipeDetailsViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var isLoading = false
    @Published var isEditing = false
    @Published var isSaving = false
    @Published var showError = false
    
    var errorMessage: String? = nil
    
    var isFormValid: Bool {
        if (recipe.displayName.isEmpty ||
            recipe.ingredients.contains { $0.name.isEmpty || $0.quantity == 0} ||
            recipe.instructions.contains { $0.isEmpty }) {
            return false
        }
        
        return true
    }
    
    private let recipeService: RecipeServiceProtocol
    private let configService: ConfigProviderProtocol
    private let originalRecipe: Recipe
    
    public init(recipe: Recipe, recipeService: RecipeServiceProtocol, configService: ConfigProviderProtocol) {
        self.recipeService = recipeService
        self.configService = configService
        self.recipe = recipe
        self.originalRecipe = recipe
    }
    
    func saveRecipe() async {
        self.isSaving = true
        self.isLoading = true
        
        
        if self.originalRecipe != self.recipe && self.isFormValid {
            self.recipe.name = self.recipe.displayName.removingAllWhiteSpaceAndNewLines().lowercased()
            
            do {
                let _ = try await self.recipeService.updateRecipe(id: self.recipe.id,
                                                            recipe: self.recipe)
                self.isEditing = false
                self.isSaving = false
                self.errorMessage = nil
                self.isLoading = false
                
            } catch {
                self.isEditing = false
                self.isSaving = false
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                self.showError = true
            }
        }
    }
    
    func deleteRecipe() async {
        self.isLoading = true
        
        do {
            try await self.recipeService.deleteRecipe(id: self.recipe.id)
            self.isLoading = false
            self.errorMessage = nil
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    func isEditingEnabled() -> Bool {
        return configService.getBool(.allowRecipeEdit)
    }
}
