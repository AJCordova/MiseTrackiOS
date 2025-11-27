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
                        } else {
                            
                        }
                    }
                }
            }
            .navigationTitle("Create Sauce")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        // handle save
                        onSauceCreated()
                    }
                }
            }
        }
    }
}
