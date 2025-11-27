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
    @Published var selectedRecipe: Recipe?
    @Published var scale: Double = 1.0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let recipeService: RecipeServiceProtocol
    private let sauceService: SauceServicesProtocol
    
    init(recipeService: RecipeServiceProtocol, sauceService: SauceServicesProtocol) {
        self.recipeService = recipeService
        self.sauceService = sauceService
    }
    
    func loadRecipes() {
        isLoading = true
        let service = recipeService
        
        Task {
            do {
                // store recipes in recipe servicesx
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
}

