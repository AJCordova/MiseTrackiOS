//
//  Ingredient.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

public struct Ingredient: Codable, Sendable {
    public let name: String
    public let quantity: Double
    public let unit: String
    
    public init(name: String, quantity: Double, unit: String = "mL") {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
