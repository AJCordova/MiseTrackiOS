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

private enum Field: Hashable {
    case quantityField
}

struct CreateSauceView: View {
    @StateObject private var viewModel: CreateSauceViewModel
    @Binding var isPresented: Bool
    
    @FocusState private var focusedField: Field?
    
    let onSauceCreated: () -> Void
    
    public init(isPresented: Binding<Bool>,
                viewModel: CreateSauceViewModel,
                onSauceCreated: @escaping () -> Void) {
        _isPresented = isPresented
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSauceCreated = onSauceCreated
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(spacing: 16) {
                        
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
                            ScaleSelector(scale: $viewModel.scale)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Actual Quantity")
                                    .font(.caption)
                                
                                HStack {
                                    TextField("Quantity", value: $viewModel.actualYield, format: .number)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.decimalPad)
                                        .focused($focusedField, equals: .quantityField)
                                    Spacer()
                                    Text("ml")
                                }
                            }
                        }
                        
                        if viewModel.actualYield > 0.00 {
                            Button("Create sauce") {
                                Task {
                                    await viewModel.createSauceBatch()
                                    isPresented = false
                                    onSauceCreated()
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Create Sauce")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK") { viewModel.showError = false }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
    }
}
