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
    @Published var errorMessage: String?
    @Published var actualYield: Double = 0.00
    
    private let recipeService: RecipeServiceProtocol
    private let sauceService: SauceServicesProtocol
    
    init(recipeService: RecipeServiceProtocol, sauceService: SauceServicesProtocol) {
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
    
    func loadRecipes() {
        isLoading = true
        let service = recipeService
        
        Task {
            do {
                // store recipes in recipe services??
                let fetched = try await service.getAllRecipes()
                
                await MainActor.run {
                    self.recipes = fetched
                    self.isLoading = false
                    self.errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func createSauceBatch() {
        guard let recipe = selectedRecipe else { return }
        isLoading = true
        let service = sauceService
        
        Task {
            do {
                _ = try await service.createSauce(name: recipe.displayName,
                                                  currentQuantity: actualYield,
                                                  unit: "ml",
                                                  batchDate: Date())
                
                await MainActor.run {
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

