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
    
    private let maxAmount = 2000.00
    let sauce: Sauce
    
    private let sauceService: SauceServicesProtocol
    
    public init(sauce: Sauce,
                sauceService: SauceServicesProtocol) {
        self.sauce = sauce
        self.sauceService = sauceService
        _viewModel = StateObject(wrappedValue: SauceDetailsViewModel(sauceService: sauceService,
                                                                     sauce: sauce))
    }
    
    var body: some View {
        Form {
            Section("Information") {
                Text("Name: \(sauce.name)")
                Text("Batch Date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
            }
            
            Section("Quantity") {
                Text("Current Quantity: \(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit.rawValue)")

                ProgressView(value: sauce.currentQuantity / maxAmount)
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
        .navigationTitle(sauce.name)
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
