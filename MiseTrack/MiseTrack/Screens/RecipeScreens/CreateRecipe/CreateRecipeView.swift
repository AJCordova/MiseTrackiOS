//
//  CreateRecipeView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

import Models
import SwiftUI
import RecipeServices

struct CreateRecipeView: View {
    @Binding var isPresented: Bool
    
    @StateObject private var viewModel: CreateRecipeViewModel
    @State private var isCreating = false
    
    let onRecipeCreated: () -> Void
    
    public init(isPresented: Binding<Bool>,
                recipeService: RecipeServiceProtocol,
                onRecipeCreated: @escaping () -> Void)
    {
        _isPresented = isPresented
        _viewModel = StateObject(wrappedValue: CreateRecipeViewModel(recipeService: recipeService))
        self.onRecipeCreated = onRecipeCreated
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack(spacing: 12) {
                        
                        // MARK: Name field
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Recipe name")
                                .font(.headline)
                            TextField("Enter recipe name", text: $viewModel.name)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        
                        // MARK: Ingredients
                        VStack(alignment: .leading, spacing: 12.0) {
                            Text("Ingredients")
                                .font(.headline)
                            
                            ForEach($viewModel.ingredients) { $ingredient in
                                HStack(spacing: 4.0) {
                                    TextField("Name", text: $ingredient.name)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("\(String(format: "%.2f", 0.00))", value: $ingredient.quantity, format: .number)
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 60)
                                    Picker("Unit", selection: $ingredient.unit) {
                                        ForEach(Units.allCases, id: \.self) { unit in
                                            Text(unit.rawValue).tag(unit)
                                        }
                                    }
                                    .frame(width: 70)
                                    
                                    if viewModel.ingredients.count > 1 {
                                        Button(action: {
                                            viewModel.ingredients.removeAll { $0.id == ingredient.id }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            
                            Button(action: {
                                viewModel.ingredients.append(Ingredient(name: "", quantity: 0.00))
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Ingredient")
                                }
                            }
                            .foregroundStyle(Color(.accent))
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        
                        // MARK: Instructions
                        VStack(alignment: .leading, spacing: 12.0) {
                            Text("Instructions")
                                .font(.headline)
                            
                            ForEach(Array(viewModel.instructions.enumerated()), id: \.offset) { index, instruction in
                                HStack(spacing: 8.0) {
                                    TextField("Instruction", text: $viewModel.instructions[index], axis: .vertical)
                                        .textFieldStyle(.roundedBorder)

                                    if viewModel.instructions.count > 1 {
                                        Button(action: {
                                            viewModel.instructions.remove(at: index)
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                            }
                            
                            Button(action: {
                                viewModel.instructions.append("")
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Ingredient")
                                }
                            }
                            .foregroundStyle(Color(.accent))
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        
                        // MARK: Approximate amount made
                        VStack(alignment: .leading, spacing: 12.0) {
                            Text("Approximate quantity created (ml)")
                                .font(.headline)
                            TextField("\(String(format: "%.2f", 0.00))", value: $viewModel.quantity, format: .number)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                    }
                }
            }
            .background(Color.background)
            .navigationTitle("Create Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        Task {
                            await viewModel.createRecipe()
                            
                            if viewModel.errorMessage == nil {
                                isPresented = false
                                onRecipeCreated()
                            }
                        }
                    }
                    .foregroundStyle(.green)
                    .disabled(viewModel.name.isEmpty || isCreating)
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        dismissKeyboard()
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK") { viewModel.showError = false }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
    }
    
    private func dismissKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,   from: nil, for: nil)
    }
}
