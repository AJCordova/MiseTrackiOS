//
//  CreateSauceViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import Foundation
import SauceServices
import RecipeServices
import Models

@MainActor
class CreateSauceViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipeID: String?
    @Published var selectedRecipe: Recipe?
    @Published var scale: Double = 1.0
    @Published var isLoading = false
    @Published var showError = false
    @Published var actualYield: Double = 0.00
    
    var errorMessage: String? = nil
    
    private let recipeService: RecipeServiceProtocol
    private let sauceService: SauceServicesProtocol
    
    public init(recipeService: RecipeServiceProtocol, sauceService: SauceServicesProtocol) {
        self.recipeService = recipeService
        self.sauceService = sauceService
    }
    
    func selectRecipe(_ recipe: Recipe) {
        self.selectedRecipe = recipe
        self.selectedRecipeID = recipe.id
        self.actualYield = 0.00
        self.scale = 1.0
    }
    
    func clearRecipe() {
        self.selectedRecipe = nil
        self.selectedRecipeID = nil
        self.actualYield = 0.00
        self.scale = 1.0
    }
    
    func loadRecipes() async {
        self.isLoading = true
        
        do {
            // store recipes in recipe services??
            let fetched = try await self.recipeService.getAllRecipes()
            self.recipes = fetched
            self.isLoading = false
            self.errorMessage = nil
            
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    func createSauceBatch() async {
        guard let recipe = self.selectedRecipe else { return }
        self.isLoading = true
        
        do {
            _ = try await self.sauceService.createSauce(name: recipe.displayName,
                                                        currentQuantity: self.actualYield,
                                                        unit: .milliliter,
                                                        batchDate: Date())
            
            self.isLoading = false
            self.errorMessage = nil
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            self.showError = false
        }
    }
}

