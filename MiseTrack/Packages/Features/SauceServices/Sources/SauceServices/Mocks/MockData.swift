//
//  MockData.swift
//  DataService
//
//  Created by Jireh Cordova on 02/12/2025.
//

import Models
import Foundation

// TODO: Preview Data / Mock Data Package? 
public struct MockData {
//    
//    // recipes
//    static let recipe1 = Recipe(id: "1",
//                                name: "recipe1",
//                                displayName: "recipe 1",
//                                ingredients: [
//                                    Ingredient(name: "ingredient1", quantity: 500),
//                                    Ingredient(name: "ingredient2", quantity: 400),
//                                    Ingredient(name: "ingredient3", quantity: 300),
//                                    Ingredient(name: "ingredient4", quantity: 200),
//                                    Ingredient(name: "ingredient5", quantity: 100),
//                                ],
//                                instructions: [
//                                    "mix all",
//                                    "transfer container"
//                                ],
//                                unit: .milliliter,
//                                volumeMl: 1000)
//    
//    static let smokyRecipe = Recipe(
//            id: "00000000-0000-0000-0000-000000000003",
//            name: "smokychipotle",
//            displayName: "Smoky Chipotle",
//            ingredients: [
//                Ingredient(name: "Chipotle Peppers", quantity: 200),
//                Ingredient(name: "Tomato Paste", quantity: 100),
//                Ingredient(name: "Apple Cider Vinegar", quantity: 300),
//                Ingredient(name: "Brown Sugar", quantity: 30),
//            ],
//            instructions: [
//                "Soak chipotles in hot water",
//                "Blend with tomato paste",
//                "Mix with vinegar and sugar",
//                "Simmer for 45 minutes",
//            ],
//            unit: .milliliter,
//            volumeMl: 800
//        )
//    
//    public static let recipes : [Recipe] = [
//        recipe1,
//        smokyRecipe,
//    ]
//    
    // sauces
    
    static let teriyakiSauce = Sauce(id: "1",
                                     name: "teriyaki sauce",
                                     currentQuantity: 2000,
                                     unit: .milliliter,
                                     batchDate: Date().addingTimeInterval(-7*24*3600))
    
    static let spicySauce = Sauce(id: "2",
                                  name: "spicy sauce",
                                  currentQuantity: 2000,
                                  unit: .milliliter,
                                  batchDate: Date().addingTimeInterval(-3*24*3600))
    
    public static let sauces: [Sauce] = [
        teriyakiSauce,
        spicySauce,
    ]
}
