//
//  SauceListView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 25/11/2025.
//

import SwiftUI
import SauceServices
import RecipeServices

struct SauceListView: View {
    @StateObject private var viewModel: SauceListViewModel
    @State private var showCreateSauceView = false
    
    private let sauceService: SauceServicesProtocol
    private let recipeService: RecipeServiceProtocol
    
    public init(sauceService: SauceServicesProtocol, recipeService: RecipeServiceProtocol) {
        self.sauceService = sauceService
        self.recipeService = recipeService
        _viewModel = StateObject(wrappedValue: SauceListViewModel(sauceService: sauceService))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if viewModel.sauces.isEmpty {
                    Text("No sauces yet")
                        .foregroundStyle(.secondaryText)
                } else if !viewModel.isLoading {
                    List {
                        ForEach(viewModel.sauces) { sauce in
                            NavigationLink(destination: SauceDetailsView(sauce: sauce,
                                                                         sauceService: sauceService)) {
                                SauceListItemView(sauce: sauce)
                            }
                        }
                    }
                    .listRowSpacing(8.0)
                }
            }
            .navigationTitle("Sauces")
            .toolbar {
                Button(action: { showCreateSauceView = true }) {
                    // Add
                    Image(systemName: "plus")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.accent)
                }
                
                Button(action: { viewModel.loadSauces() }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .sheet(isPresented: $showCreateSauceView) {
                CreateSauceView(isPresented: $showCreateSauceView,
                                recipeService: recipeService,
                                sauceService: sauceService) {
                    viewModel.loadSauces()
                }
            }
            .onAppear {
                viewModel.loadSauces()
            }
        }
    }
}

#Preview {
//    SauceListView()
}
