//
//  Ingredient.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

import Foundation

public struct Ingredient: Identifiable, Codable, Sendable {
    public let id: String
    public var name: String
    public var quantity: Double
    public var unit: Units
    
    public init(id: String = UUID().uuidString, name: String, quantity: Double, unit: Units = .milliliter) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
