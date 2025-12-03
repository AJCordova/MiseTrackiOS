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
    @Published var ingredients: [Ingredient] = [Ingredient(name: "", quantity: 0.00, unit: .milliliter)]
    @Published var instructions: [String] = [""]
    @Published var quantity: Double = 0.00
    @Published var isLoading = false
    @Published var showError: Bool = false
    
    var errorMessage: String? = nil
    
    private let recipeService: RecipeServiceProtocol
    
    public init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func createRecipe() async {
        self.isLoading = true
        
        guard !self.name.isEmpty, !self.ingredients.isEmpty, !self.instructions.isEmpty, !self.quantity.isZero  else {
            self.isLoading = false
            self.errorMessage = "Some fields are empty."
            self.showError = true
            return
        }
        
        let validIngredients = self.ingredients.filter { !$0.name.isEmpty && !$0.quantity.isZero }
        
        guard validIngredients.count == self.ingredients.count else {
            self.isLoading = false
            self.errorMessage = "Some ingredients are missing information."
            self.showError = true
            return
        }
        
        let validInstructions = self.instructions.filter { !$0.isEmpty }
        do {
            _ = try await recipeService.createRecipe(name: createNormalizedString(from: name),
                                                     displayName: self.name,
                                                     ingredients: validIngredients,
                                                     instructions: validInstructions,
                                                     unit: .milliliter,
                                                     volumeML: quantity)
            
            self.isLoading = false
            self.showError = false
            self.errorMessage = nil
        } catch {
            self.presentThrownError(error)
        }
    }
    
    private func createNormalizedString(from value: String) -> String {
        return value.removingAllWhiteSpaceAndNewLines().lowercased()
    }
    
    private func presentThrownError(_ error: Error) {
        self.isLoading = false
        self.errorMessage = error.localizedDescription
        self.showError = true
    }
}

