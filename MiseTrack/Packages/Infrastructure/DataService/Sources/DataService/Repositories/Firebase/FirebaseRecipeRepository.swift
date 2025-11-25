//
//  FirebaseRecipeRepository.swift
//  DataService
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation
import Models
import FirebaseServices

public actor FirebaseRecipeRepository: RecipeRepositoryProtocol {
    private let firebaseClient: FirebaseClient
    private let collectionName = "recipes"
    
    public init(firebaseClient: FirebaseClient = .shared) {
        self.firebaseClient = firebaseClient
    }
    
//    public func fetchAll() async throws -> [Recipe] {
//        let records = try await firebaseClient
//            .collection(collectionName)
//            .order(by: "name")
//            .getDocuments()
//        
//        let recipes = records.map { record in
//            let data = record.data()
//            return Recipe(id: record.documentID,
//                          name: data?["name"] as? String ?? "",
//                          displayName: data?["displayName"] as? String ?? "",
//                          ingredients: data?["ingredients"] as? [Ingredient] ?? [],
//                          instructions: data?["instructions"] as? [String] ?? [],
//                          unit: data?["unit"] as? String ?? "mL",
//                          volumeMl: data?["volumeMl"] as? Double ?? 0.00)
//        }
//        
//        return recipes
//    }
    
    public func fetchAll() async throws -> [Recipe] {
        let records = try await firebaseClient
            .collection(collectionName)
            .order(by: "name")
            .getDocuments()
        
        let recipes = try records.map { record in
            try record.data(as: Recipe.self)
        }
        
        return recipes
    }
    
    public func fetch(id: String) async throws -> Recipe {
        let record = try await firebaseClient
            .collection(collectionName)
            .document(id)
            .getDocument()
        
        return try record.data(as: Recipe .self)
    }
    
    public func create(_ recipe: Recipe) async throws -> Recipe {
        try await firebaseClient
            .collection(collectionName)
            .document(recipe.id)
            .setData(recipe)
        
        return recipe
    }
    
    public func update(_ recipe: Recipe) async throws -> Recipe {
        try await firebaseClient
            .collection(collectionName)
            .document(recipe.id)
            .updateData(recipe)
        
        return recipe
    }
    
    public func delete(id: String) async throws {
        try await firebaseClient
            .collection(collectionName)
            .document(id)
            .delete()
    }
}
