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
    @State private var showDeleteConfirmation = false
    @State private var showError = false
    
    @Environment(\.dismiss) var dismiss
    
    public init(recipe: Recipe,
                recipeService: RecipeServiceProtocol) {
        _viewModel = StateObject(wrappedValue: RecipeDetailsViewModel(recipe: recipe,
                                                                      service: recipeService))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    
                    // MARK: recipe name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recipe Name")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        if viewModel.isEditing {
                            TextField("Recipe name", text: $viewModel.recipe.displayName)
                                
                        } else {
                            Text(viewModel.recipe.displayName)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Total yield
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Amount")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        if viewModel.isEditing {
                            HStack {
                                TextField("Quantity", value: $viewModel.recipe.volumeMl, format: .number)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                                Text(viewModel.recipe.unit.rawValue)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text("\(String(format: "%.0f", viewModel.recipe.volumeMl)) \(viewModel.recipe.unit.rawValue)")
                                .font(.body)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Ingredients
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        if viewModel.isEditing {
                            ForEach($viewModel.recipe.ingredients) { $ingredient in
                                HStack(spacing: 4) {
                                    TextField("Name", text: $ingredient.name)
                                        .textFieldStyle(.roundedBorder)
                                    
                                    TextField("0.00", value: $ingredient.quantity, format: .number)
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 60)
                                    
                                    Picker("Unit", selection: $ingredient.unit) {
                                        ForEach(Units.allCases, id: \.self) { unit in
                                            Text(unit.rawValue).tag(unit)
                                        }
                                    }
                                    .frame(width: 70)
                                    
                                    if viewModel.recipe.ingredients.count > 1 {
                                        Button(action: {
                                            viewModel.recipe.ingredients.removeAll { $0.id == ingredient.id }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            
                            Button(action: {
                                viewModel.recipe.ingredients.append(Ingredient(name: "", quantity: 0.00))
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Ingredient")
                                }
                            }
                            .foregroundStyle(Color(.accent))
                        }
                        else {
                            ForEach(viewModel.recipe.ingredients) { ingredient in
                                HStack {
                                    Text(ingredient.name)
                                    Spacer()
                                    Text("\(String(format: "%.2f", ingredient.quantity)) \(ingredient.unit.rawValue)")
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Instructions
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instructions")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        ForEach(Array(viewModel.recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            if index > 0 {
                                Divider()
                            }
                            Text("\(index + 1). \(instruction)")
                                .font(.subheadline)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
            }
            .navigationTitle(viewModel.recipe.displayName)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        viewModel.isEditing = false
//                    }
//                    .foregroundStyle(.red)
//                }
//                
//                Button(action: { viewModel.isEditing = true }) {
//                    // Edit
//                    Image(systemName: "square.and.pencil")
//                        .symbolRenderingMode(.monochrome)
//                        .foregroundStyle(.accent)
//                }
//                
//                Button(action: {  }) {
//                    // Delete
//                    Image(systemName: "trash")
//                        .symbolRenderingMode(.monochrome)
//                        .foregroundStyle(.red)
//                }
//            }
            
        }
    }
}
