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
    @EnvironmentObject var service: ServiceContainer
    @StateObject private var viewModel: RecipeListViewModel
    @State private var showCreateRecipeView = false

    public init(viewModel: RecipeListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                            NavigationLink(destination: RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe,
                                                                                                            recipeService: service.recipeService,
                                                                                                            configService: service.configService)))
                            {
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
                if viewModel.isEditingEnabled() {
                    Button(action: { showCreateRecipeView = true }) {
                        Image(systemName: "plus")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(.accent)
                    }
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
                                 recipeService: service.recipeService) {
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
