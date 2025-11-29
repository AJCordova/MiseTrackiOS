//
//  RecipeDetailsViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

import Foundation
import RecipeServices
import Models

@MainActor
class RecipeDetailsViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var isLoading = false
    @Published var isEditing = false
    @Published var isSaving = false
    @Published var errorMessage: String?
    
    var isFormValid: Bool {
        if (recipe.displayName.isEmpty ||
            recipe.ingredients.contains { $0.name.isEmpty || $0.quantity == 0} ||
            recipe.instructions.contains { $0.isEmpty }) {
            return false
        }
        
        return true
    }
    
    private let service: RecipeServiceProtocol
    private let originalRecipe: Recipe
    
    public init(recipe: Recipe, service: RecipeServiceProtocol) {
        self.service = service
        self.recipe = recipe
        self.originalRecipe = recipe
    }
    
    func saveRecipe() async throws {
        isSaving = true
        errorMessage = nil
        
        if originalRecipe != recipe && isFormValid {
            recipe.name = recipe.displayName.removingAllWhiteSpaceAndNewLines().lowercased()
            Task {
                let _ = try await service.updateRecipe(id: recipe.id,
                                                       recipe: recipe)
                self.isEditing = false
                self.isSaving = false
            }
        } else {
            errorMessage = "There was an error in saving your recipe."
        }
    }
    
    func deleteRecipe() async throws {
        try await service.deleteRecipe(id: recipe.id)
    }
}
