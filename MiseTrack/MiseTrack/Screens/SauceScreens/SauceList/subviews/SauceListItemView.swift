//
//  SauceListItemView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import SwiftUI
import Models

struct SauceListItemView: View {
    let sauce: Sauce
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(sauce.name).font(.headline)
                Text("Batch date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                Text("Expires: *config here*")
                    .font(.caption)
                Spacer()
                Text("Notes")
                    .font(.footnote)
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit)")
                    .font(.title3)
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
    SauceListItemView(sauce: sauce)
}
