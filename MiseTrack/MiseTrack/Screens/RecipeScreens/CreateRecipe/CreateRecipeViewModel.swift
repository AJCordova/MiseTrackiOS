//
//  CreateRecipeViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

import Foundation
import Models
import RecipeServices

@MainActor
class CreateRecipeViewModel: ObservableObject {
    @Published var name = ""
    @Published var ingredients: [Ingredient] = []
    @Published var instructions: [String] = [""]
    @Published var volumeMl: Double = 0.00
    @Published var shouldDismissView = false
    
    private let recipeService: RecipeServiceProtocol
    
    public init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func createRecipe() async throws {
        guard !name.isEmpty, !ingredients.isEmpty, !instructions.isEmpty, !volumeMl.isZero  else {
            throw RecipeServiceError.invalidInput("Some fields are empty.")
        }
        
        let validIngredients = ingredients.filter { !$0.name.isEmpty && !$0.quantity.isZero }
        guard validIngredients.count == ingredients.count else {
            throw RecipeServiceError.invalidInput("Some ingredients are missing information.")
        }
        
        let validInstructions = instructions.filter { !$0.isEmpty }
        _ = try await recipeService.createRecipe(name: name,
                                                 displayName: name,
                                                 ingredients: validIngredients,
                                                 instructions: validInstructions,
                                                 unit: .milliliter,
                                                 volumeML: volumeMl)
        shouldDismissView = true
    }
}

