//
//  SauceDetailsView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import SwiftUI
import Models

struct SauceDetailsView: View {
    let sauce: Sauce
    @State private var consumeAmount: String = ""
    private let maxAmount = 2000.00
    
    var body: some View {
        Form {
            Section("Information") {
                Text("Name: \(sauce.name)")
                Text("Batch Date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
            }
            
            Section("Quantity") {
                Text("Current Quantity: \(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit)")

                ProgressView(value: sauce.currentQuantity / maxAmount)
            }
            
            Section("Consume") {
                HStack {
                    TextField("Amount (ml)", text: $consumeAmount)
                        .keyboardType(.decimalPad)
                    Button("Consume") {
                        //
                    }
                }
            }
        }
        .navigationTitle(sauce.name)
        .toolbar {
            Button(action: {
                // delete sauce
            }) {
                Image(systemName: "trash")
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    let sauce: Sauce = Sauce(id: "avkoCt61EGVLvjC1t0Ph",
                             name: "Teriyaki Sauce",
                             currentQuantity: 500.00,
                             unit: "mL",
                             batchDate: Date())
    SauceDetailsView(sauce: sauce)
}
