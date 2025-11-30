//
//  SauceDetailsView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import SwiftUI
import Models
import SauceServices
import RecipeServices

private enum Field: Hashable {
    case consume
}

struct SauceDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: Field?
    
    @StateObject private var viewModel: SauceDetailsViewModel
    
    @State private var showDeleteConfirmation: Bool = false
    
    private let maxAmount = 2000.00 // TODO: value should come from viewmodel -> config
    private let sauceService: SauceServicesProtocol
    
    private var safeMaxAmount: Double { max(maxAmount, 0.0001) }
    private var clampedProgress: Double { min(max(viewModel.sauce.currentQuantity, 0), safeMaxAmount) }
    
    public init(sauce: Sauce,
                sauceService: SauceServicesProtocol) {
        self.sauceService = sauceService
        _viewModel = StateObject(wrappedValue: SauceDetailsViewModel(sauceService: sauceService,
                                                                     sauce: sauce))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Form {
                    Section("Information") {
                        Text("Name: \(viewModel.sauce.name)")
                        Text("Batch Date: \(viewModel.sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                    }
                    
                    Section("Quantity") {
                        Text("Current Quantity: \(String(format: "%.2f", viewModel.sauce.currentQuantity)) \(viewModel.sauce.unit.rawValue)")
                        ProgressView(value: clampedProgress, total: safeMaxAmount)
                    }
                    
                    Section("Consume") {
                        HStack {
                            TextField("Amount (ml)", value: $viewModel.amount, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .consume)
                            Button("Consume") {
                                Task {
                                    try await viewModel.consume()
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.sauce.name)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
            
            ToolbarItemGroup(placement: .confirmationAction) {
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Image(systemName: "trash")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.red)
                }
            }
        }
        .alert("", isPresented: $showDeleteConfirmation) {
            Button("DELETE") {
                Task {
                    try await viewModel.delete()
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
    }
}

#Preview {
//    let sauce: Sauce = Sauce(id: "avkoCt61EGVLvjC1t0Ph",
//                             name: "Teriyaki Sauce",
//                             currentQuantity: 500.00,
//                             unit: "mL",
//                             batchDate: Date())
//    SauceDetailsView(sauce: sauce)
}
