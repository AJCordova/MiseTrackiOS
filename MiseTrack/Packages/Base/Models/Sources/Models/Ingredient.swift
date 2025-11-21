//
//  Ingredient.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

public struct Ingredient: Codable {
    public let name: String
    public let quantity: Double
    public let unit: String
    
    public init(name: String, quantity: Double, unit: String = "g") {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
