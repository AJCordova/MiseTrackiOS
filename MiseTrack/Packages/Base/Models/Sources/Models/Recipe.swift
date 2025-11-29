//
//  RecipeModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

public struct Recipe: Identifiable, Codable, Sendable, Equatable {
    public let id: String
    public var name: String
    public var displayName: String
    public var ingredients: [Ingredient]
    public var instructions: [String]
    public let unit: Units
    public var volumeMl: Double
    
    public init(id: String,
                name: String,
                displayName: String,
                ingredients: [Ingredient],
                instructions: [String],
                unit: Units,
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
