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
    func fetch(id: UUID) async throws -> Recipe
    func create(_ sauce: Recipe) async throws -> Recipe
    func update(_ sauce: Recipe) async throws -> Recipe
    func delete(id: UUID) async throws
}
