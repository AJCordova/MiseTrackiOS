//
//  RecipeModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

public struct Recipe: Identifiable, Codable {
    public let id: String
    public let name: String
    public let displayName: String
    public let ingredients: [Ingredient]
    public let instructions: [String]
    public let unit: String
    public let volumeMl: Double
    
    public init(id: String,
                name: String,
                displayName: String,
                ingredients: [Ingredient],
                instructions: [String],
                unit: String,
                volumeMl: Double) {
        self.id = id
        self.name = name
        self.displayName = displayName
        self.ingredients = ingredients
        self.instructions = instructions
        self.unit = unit
        self.volumeMl = volumeMl
    }
}
