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
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(sauce.name).font(.headline)
                                    Text("Batch date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.subheadline)
                                    Text("Expires: *config here*")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("\(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit)")
                                        .font(.title3)
                                }
                            }
                        }
                        
                        ForEach(viewModel.sauces) { sauce in
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(sauce.name).font(.headline)
                                    Text("Batch date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.subheadline)
                                    Text("Expires: *config here*")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("\(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit)")
                                        .font(.title3)
                                }
                            }
                        }
                        
                        ForEach(viewModel.sauces) { sauce in
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(sauce.name).font(.headline)
                                    Text("Batch date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.subheadline)
                                    Text("Expires: *config here*")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("\(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit)")
                                        .font(.title3)
                                }
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
