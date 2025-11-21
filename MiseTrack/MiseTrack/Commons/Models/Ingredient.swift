//
//  Ingredient.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

struct Ingredient: Identifiable, Codable {
    let id: String
    let name: String
    let quantity: Double
    let unit: String
}
