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
    @EnvironmentObject var service: ServiceContainer
    @StateObject private var viewModel: RecipeDetailsViewModel
    @State private var showDeleteConfirmation = false
    @State private var showError = false
    
    @Environment(\.dismiss) var dismiss
    
    public init(viewModel: RecipeDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        // MARK: recipe name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recipe Name")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            if viewModel.isEditing {
                                TextField("Recipe name", text: $viewModel.recipe.displayName)
                                    .textFieldStyle(.roundedBorder)
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
                        VStack(alignment: .leading, spacing: 8) {
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
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            if viewModel.isEditing {
                                ForEach(Array(viewModel.recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                                    HStack(spacing: 8) {
                                        TextField(instruction, text: $viewModel.recipe.instructions[index], axis: .vertical)
                                            .textFieldStyle(.roundedBorder)
                                        
                                        if viewModel.recipe.instructions.count > 1 {
                                            Button(action: {
                                                viewModel.recipe.instructions.remove(at: index)
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    viewModel.recipe.instructions.append("")
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Add Ingredient")
                                    }
                                }
                                .foregroundStyle(Color(.accent))
                                
                            } else {
                                ForEach(Array(viewModel.recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                                    Text("\(index + 1). \(instruction)")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .background(viewModel.isEditing ? Color(.systemGray6) : Color.background)
            .navigationTitle("Recipe Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !viewModel.isEditing && viewModel.isEditingEnabled() {
                    Button(action: {
                        viewModel.isEditing = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(.accent)
                    }
                    
                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        Image(systemName: "trash")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(.red)
                    }
                } else {
                    if viewModel.isFormValid && viewModel.isEditingEnabled() {
                        Button(action: {
                            viewModel.isEditing = false
                            Task {
                                await viewModel.saveRecipe()
                                dismiss()
                            }
                        }) {
                            Text("Save")
                        }
                        .foregroundStyle(.green)
                        
                        Button(action: {
                            viewModel.isEditing = false
                        }) {
                            Text("Cancel")
                        }
                        .foregroundStyle(.red)
                    }
                }
            }
        }
        .background(Color.background)
        .alert("", isPresented: $showDeleteConfirmation) {
            Button("DELETE") {
                Task {
                    await viewModel.deleteRecipe()
                    dismiss()
                }
            }
            .foregroundStyle(.red)
            
            Button("Cancel") {
                showDeleteConfirmation = false
            }
            
        } message: {
            Text("Are you sure you want to delete this recipe? This cannot be undone.")
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { showError = false }
        } message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    dismissKeyboard()
                }
            }
        }
    }
    
    private func dismissKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,   from: nil, for: nil)
    }
}
