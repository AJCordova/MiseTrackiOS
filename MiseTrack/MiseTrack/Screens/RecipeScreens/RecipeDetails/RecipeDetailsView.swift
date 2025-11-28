//
//  RecipeDetailsView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 27/11/2025.
//

import Foundation
import SwiftUI
import Models
import RecipeServices

struct RecipeDetailsView: View {
    @StateObject private var viewModel: RecipeDetailsViewModel
    
    public init(recipe: Recipe,
                recipeService: RecipeServiceProtocol) {
        _viewModel = StateObject(wrappedValue: RecipeDetailsViewModel(recipe: recipe,
                                                                      service: recipeService))
    }
    var body: some View {
        VStack {
            Text(viewModel.recipe.displayName)
        }
    }
}
