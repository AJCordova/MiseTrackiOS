//
//  RecipeModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let ingredients: [Ingredient]
    let instructions: [String]
    let yieldUnit: String // 
    let yieldQuantity: Double?
}
