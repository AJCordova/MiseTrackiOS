//
//  RecipeRepositoryProtocol.swift
//  DataService
//
//  Created by Jireh Cordova on 24/11/2025.
//
import Foundation
import Models

public protocol RecipeRepositoryProtocol: Sendable {
    func fetchAll() async throws -> [Recipe]
    func fetch(id: String) async throws -> Recipe
    func create(_ recipe: Recipe) async throws -> Recipe
    func update(_ recipe: Recipe) async throws -> Recipe
    func delete(id: String) async throws
}
