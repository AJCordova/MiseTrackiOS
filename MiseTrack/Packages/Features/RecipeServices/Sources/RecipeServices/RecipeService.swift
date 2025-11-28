// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models
import DataService

public final class RecipeService: RecipeServiceProtocol {
    private let repository: RecipeRepositoryProtocol
    
    public init(repository: RecipeRepositoryProtocol? = nil) {
        if let repository {
            self.repository = repository
        } else {
            self.repository = DataService.shared.makeRecipeRepository()
        }
    }
    
    public func getAllRecipes() async throws -> [Recipe] {
        return try await repository.fetchAll()
    }
    
    public func getRecipe(id: String) async throws -> Recipe {
        return try await repository.fetch(id: id)
    }
    
    public func createRecipe(name: String,
                             displayName: String,
                             ingredients: [Models.Ingredient],
                             instructions: [String],
                             unit: String,
                             volumeML: Double) async throws -> Recipe {
        
        guard !name.isEmpty else {
            throw RecipeServiceError.invalidInput("Name cannot be empty")
        }
        
        let recipe = Recipe(id: UUID().uuidString,
                            name: name,
                            displayName: displayName,
                            ingredients: ingredients,
                            instructions: instructions,
                            unit: unit,
                            volumeMl: volumeML)
        
        return try await repository.create(recipe)
    }
    
    public func updateRecipe(id: String, recipe: Recipe) async throws -> Recipe {
//        let current = try await repository.fetch(id: id)
        return try await repository.update(recipe)
    }
    
    public func deleteRecipe(id: String) async throws {
        try await repository.delete(id: id)
    }
    
    
}
