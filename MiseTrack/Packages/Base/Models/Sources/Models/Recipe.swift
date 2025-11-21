//
//  RecipeModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

public struct Recipe: Identifiable, Codable {
    public let id: String
    public let name: String
    public let ingredients: [Ingredient]
    public let instructions: [String]
    public let yieldUnit: String 
    public let yieldQuantity: Double?
    
    public init(id: String, name: String, ingredients: [Ingredient], instructions: [String], yieldUnit: String, yieldQuantity: Double?) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.yieldUnit = yieldUnit
        self.yieldQuantity = yieldQuantity
    }
}
