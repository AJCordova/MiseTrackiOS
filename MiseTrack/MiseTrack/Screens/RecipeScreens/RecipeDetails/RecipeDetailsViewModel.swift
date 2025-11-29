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
    
    private let service: RecipeServiceProtocol
    
    public init(recipe: Recipe, service: RecipeServiceProtocol) {
        self.service = service
        self.recipe = recipe
    }
    
    func saveRecipe() async throws {
        isSaving = true
        errorMessage = nil
        
        let _ = try await service.updateRecipe(id: recipe.id,
                                                       recipe: recipe)
        self.isEditing = false
        self.isSaving = false
    }
    
    func deleteRecipe() async throws {
        try await service.deleteRecipe(id: recipe.id)
    }
}
