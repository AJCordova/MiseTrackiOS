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

struct SauceDetailsView: View {
    @StateObject private var viewModel: SauceDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let maxAmount = 2000.00 // TODO: value should come from viewmodel -> config
    private let sauceService: SauceServicesProtocol
    
    public init(sauce: Sauce,
                sauceService: SauceServicesProtocol) {
        self.sauceService = sauceService
        _viewModel = StateObject(wrappedValue: SauceDetailsViewModel(sauceService: sauceService,
                                                                     sauce: sauce))
    }
    
    var body: some View {
        Form {
            Section("Information") {
                Text("Name: \(viewModel.sauce.name)")
                Text("Batch Date: \(viewModel.sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
            }
            
            Section("Quantity") {
                Text("Current Quantity: \(String(format: "%.2f", viewModel.sauce.currentQuantity)) \(viewModel.sauce.unit.rawValue)")

                // TODO: REVIEW
                // Clamp progress between 0 and 1 and provide a total for clarity
                let safeMax = max(maxAmount, 0.0001)
                let clampedProgress = min(max(viewModel.sauce.currentQuantity, 0), safeMax)
                ProgressView(value: clampedProgress, total: safeMax)
            }
            
            Section("Consume") {
                HStack {
                    TextField("Amount (ml)", value: $viewModel.amount, format: .number)
                        .keyboardType(.decimalPad)
                    Button("Consume") {
                        viewModel.consume()
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle(viewModel.sauce.name)
        .toolbar {
            Button(action: {
                viewModel.delete()
                dismiss()
            }) {
                Image(systemName: "trash")
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.red)
            }
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

