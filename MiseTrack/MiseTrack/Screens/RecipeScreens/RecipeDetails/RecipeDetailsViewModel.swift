//
//  RecipeDetailsViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

import Foundation
import RecipeServices
import Models

@MainActor
class RecipeDetailsViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: RecipeServiceProtocol
    
    public init(recipe: Recipe, service: RecipeServiceProtocol) {
        self.service = service
        self.recipe = recipe
    }
}
