//
//  SauceListView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 25/11/2025.
//

import SwiftUI
import SauceServices

struct SauceListView: View {
    @StateObject private var viewModel: SauceListViewModel
    
    public init(sauceService: SauceServicesProtocol = SauceService()) {
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
                } else {
                    List {
                        ForEach(viewModel.sauces) { sauce in
                            NavigationLink(destination: SauceDetailsView(sauce: sauce)) {
                                SauceListItemView(sauce: sauce)
                            }
                        }
                        
                        ForEach(viewModel.sauces) { sauce in
                            NavigationLink(destination: SauceDetailsView(sauce: sauce)) {
                                SauceListItemView(sauce: sauce)
                            }
                        }
                        
                        ForEach(viewModel.sauces) { sauce in
                            NavigationLink(destination: SauceDetailsView(sauce: sauce)) {
                                SauceListItemView(sauce: sauce)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Sauces")
            .toolbar {
                Button(action: {}) {
                    // Add
                    Image(systemName: "plus")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.accent)
                }
                
                Button(action: {}) {
                    // Refresh
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear {
            viewModel.loadSauces()
        }
    }
}

#Preview {
    SauceListView()
}
