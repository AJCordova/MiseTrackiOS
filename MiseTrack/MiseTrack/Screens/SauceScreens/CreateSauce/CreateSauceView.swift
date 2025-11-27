//
//  CreateSauceView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import SwiftUI
import SauceServices
import RecipeServices
import Models

struct CreateSauceView: View {
    @StateObject private var viewModel: CreateSauceViewModel
    @Binding var isPresented: Bool
    
    private let sauceService: SauceServicesProtocol
    private let recipeService: RecipeServiceProtocol
    
    let onSauceCreated: () -> Void
    
    public init(isPresented: Binding<Bool>,
                recipeService: RecipeServiceProtocol,
                sauceService: SauceServicesProtocol,
                onSauceCreated: @escaping () -> Void) {
        self.sauceService = sauceService
        self.recipeService = recipeService
        _isPresented = isPresented
        _viewModel = StateObject(wrappedValue: CreateSauceViewModel(recipeService: recipeService,
                                                                    sauceService: sauceService))
        self.onSauceCreated = onSauceCreated
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: Choose recipe
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select recipe")
                        
                        if viewModel.isLoading {
                            ProgressView()
                        } else if viewModel.recipes.isEmpty {
                            Text("No recipes available")
                                .foregroundStyle(.second)
                        } else if viewModel.selectedRecipe == nil {
                            VStack(spacing: 8) {
                                ForEach(viewModel.recipes) { recipe in
                                    RecipePreviewCardView(recipe: recipe,
                                                          scale: viewModel.scale,
                                                          isSelected: viewModel.selectedRecipeID == recipe.id,
                                                          onSelect: { viewModel.selectRecipe(recipe) },
                                                          onDeselect: { viewModel.clearRecipe() })
                                }
                            }
                        } else if let recipe = viewModel.selectedRecipe {
                            RecipePreviewCardView(recipe: recipe,
                                                  scale: viewModel.scale,
                                                  isSelected: viewModel.selectedRecipeID == recipe.id,
                                                  onSelect: { viewModel.selectRecipe(recipe) },
                                                  onDeselect: { viewModel.clearRecipe() })
                        }
                    }
                    
                    if viewModel.selectedRecipe != nil {
                        // MARK: Scale setting
                        ScaleSelector(scale: $viewModel.scale)
                        
                        // MARK: Actual quantity input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Actual Quantity")
                                .font(.caption)
                            
                            HStack {
                                TextField("Quantity", value: $viewModel.actualYield, format: .number)
                                    .keyboardType(.decimalPad)
                                Spacer()
                                Text("ml")
                            }
                        }
                    }
                    
                    if viewModel.actualYield > 0.00 {
                        Button("Create sauce") {
                            viewModel.createSauceBatch()
                            isPresented = false
                            onSauceCreated()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Create Sauce")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }
}
