//
//  RecipeListView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI
import Models
import RecipeServices

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeListViewModel
    @State private var showCreateRecipeView = false
    
    private let recipeService: RecipeServiceProtocol
    
    public init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        _viewModel = StateObject(wrappedValue: RecipeListViewModel(recipeService: recipeService))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if viewModel.recipes.isEmpty {
                    Text("No recipes created")
                } else if !viewModel.isLoading {
                    List {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe,
                                                                          recipeService: recipeService)) {
                                Text("\(recipe.displayName)")
                                    .font(.headline)
                            }
                        }
                    }
                    .listRowSpacing(4.0)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                Button(action: { showCreateRecipeView = true }) {
                    Image(systemName: "plus")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.accent)
                }
                
                Button(action: {
                    Task {
                        await viewModel.loadRecipes()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .sheet(isPresented: $showCreateRecipeView) {
                CreateRecipeView(isPresented: $showCreateRecipeView,
                                 recipeService: recipeService) {
                    Task {
                        await viewModel.loadRecipes()
                    }
                }
            }
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
}

#Preview {
//    RecipeListView()
}
