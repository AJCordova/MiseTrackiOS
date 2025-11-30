//
//  RecipeServiceProtocol.swift
//  RecipeServices
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation
import Models
import DataService

public protocol RecipeServiceProtocol: Sendable {
    func getAllRecipes() async throws -> [Recipe]
    func getRecipe(id: String) async throws -> Recipe
    func createRecipe(name: String,
                      displayName: String,
                      ingredients: [Ingredient],
                      instructions: [String],
                      unit: Units,
                      volumeML: Double) async throws -> Recipe
    func updateRecipe(id: String, recipe: Recipe) async throws -> Recipe
    func deleteRecipe(id: String) async throws
}
