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
    @EnvironmentObject var service: ServiceContainer
    @StateObject private var viewModel: SauceListViewModel
    @State private var showCreateSauceView = false
    
    public init(viewModel: SauceListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                            NavigationLink(destination: SauceDetailsView(viewModel: SauceDetailsViewModel(sauce: sauce,
                                                                                                          sauceService: service.sauceService,
                                                                                                          configService: service.configService)))
                            {
                                SauceListItemView(sauce: sauce,
                                                  expirationDate: viewModel.getExpirationDate(for: sauce),
                                                  freshnessStatus: viewModel.getFreshStatus(for: sauce),
                                                  quantityStatus: viewModel.getQuantityStatus(for: sauce))
                            }
                        }
                    }
                    .listRowSpacing(8.0)
                }
            }
            .navigationTitle("Sauces")
            .toolbar {
                Button(action: { showCreateSauceView = true }) {
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
                                viewModel: CreateSauceViewModel(recipeService: service.recipeService,
                                                                sauceService: service.sauceService)) {
                    viewModel.loadSauces()
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK") { viewModel.showError = false }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
            .task {
                viewModel.loadSauces()
            }
        }
    }
}

#Preview {
//    SauceListView()
}
