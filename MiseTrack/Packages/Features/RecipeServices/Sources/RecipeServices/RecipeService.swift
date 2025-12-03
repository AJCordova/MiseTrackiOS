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
        do {
            let recipes = try await repository.fetchAll()
            return recipes
        } catch {
            
            throw RecipeServiceError.dataServiceError(error)
        }
    }
    
    public func getRecipe(id: String) async throws -> Recipe {
        do {
            let recipe = try await repository.fetch(id: id)
            return recipe
        } catch {
            throw RecipeServiceError.dataServiceError(error)
        }
        
    }
    
    public func createRecipe(name: String,
                             displayName: String,
                             ingredients: [Models.Ingredient],
                             instructions: [String],
                             unit: Units,
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
        
        do {
            let recipe = try await repository.create(recipe)
            return recipe
        } catch {
            throw RecipeServiceError.dataServiceError(error)
        }
    }
    
    public func updateRecipe(id: String, recipe: Recipe) async throws -> Recipe {
        do {
            let recipe = try await repository.update(recipe)
            return recipe
        } catch {
            throw RecipeServiceError.dataServiceError(error)
        }
    }
    
    public func deleteRecipe(id: String) async throws {
        do {
            try await repository.delete(id: id)
        } catch {
            throw RecipeServiceError.dataServiceError(error)
        }
    }
    
    
}
