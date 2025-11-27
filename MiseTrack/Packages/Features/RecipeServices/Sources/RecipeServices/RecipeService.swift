// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models
import DataService

public class RecipeService: RecipeServiceProtocol {
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
    
    public func updateRecipe(id: UUID, recipe: Recipe) async throws -> Recipe {
        let current = try await repository.fetch(id: id.uuidString)
//        let updated = Recipe(id: <#T##String#>, name: <#T##String#>, displayName: <#T##String#>, ingredients: <#T##[Ingredient]#>, instructions: <#T##[String]#>, unit: <#T##String#>, volumeMl: <#T##Double#>)
        return try await repository.update(recipe)
    }
    
    public func deleteSauce(id: UUID) async throws {
        try await repository.delete(id: id.uuidString)
    }
    
    
}
