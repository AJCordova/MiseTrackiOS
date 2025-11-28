//
//  Ingredient.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

import Foundation

public struct Ingredient: Identifiable, Codable, Sendable {
    public let id: String
    public let name: String
    public let quantity: Double
    public let unit: Units
    
    public init(id: String, name: String, quantity: Double, unit: Units = .milliliter) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
