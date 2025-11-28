//
//  RecipeListViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 27/11/2025.
//

import Foundation
import Models
import RecipeServices

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func loadRecipes() {
        isLoading = true
        let service = recipeService
        
        Task {
            do {
                let recipes = try await service.getAllRecipes()
                
                await MainActor.run { [weak self] in
                    self?.recipes = recipes
                    self?.isLoading = false
                    self?.errorMessage = nil
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                }
            }
        }
    }
}

