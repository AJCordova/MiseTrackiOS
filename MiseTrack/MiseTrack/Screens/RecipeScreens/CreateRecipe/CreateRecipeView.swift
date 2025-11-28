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
    
    @State private var showError = false
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
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Recipe name")
                            .font(.headline)
                        TextField("Enter recipe name", text: $viewModel.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(.background))
                    
                }
            }
            .navigationTitle("Create Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        Task {
                            do {
                                try await viewModel.createRecipe()
                                isPresented = false
                                onRecipeCreated()
                            } catch {
                                // TODO: error handling
                            }
                            isCreating = false
                        }
                    }
                    .disabled(viewModel.name.isEmpty || isCreating)
                }
            }
        }
    }
}
