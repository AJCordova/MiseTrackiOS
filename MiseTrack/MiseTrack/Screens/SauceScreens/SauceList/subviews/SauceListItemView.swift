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
    let expirationDate: Date
    let freshnessStatus: FreshnessStatus
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(sauce.name).font(.headline)
                Text("Batch date: \(sauce.batchDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                Text("Expires: \(expirationDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                Spacer()
                Text(getFreshnessStatus())
                    .font(.footnote)
            }
            
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(String(format: "%.2f", sauce.currentQuantity)) \(sauce.unit.rawValue)")
                    .font(.title3)
            }
        }
    }
    
    private func getFreshnessStatus() -> String {
        switch freshnessStatus {
        case .expired: return "Expired"
        case .expiringSoon: return "Expiring soon"
        case .fresh: return "Fresh"
        }
    }
}



#Preview {
    let sauce: Sauce = Sauce(id: "avkoCt61EGVLvjC1t0Ph",
                             name: "Teriyaki Sauce",
                             currentQuantity: 500.00,
                             unit: .milliliter,
                             batchDate: Date())
    SauceListItemView(sauce: sauce, expirationDate: sauce.batchDate.addingTimeInterval(259200), freshnessStatus: .expiringSoon)
    SauceListItemView(sauce: sauce, expirationDate: sauce.batchDate.addingTimeInterval(259200), freshnessStatus: .expired)
    SauceListItemView(sauce: sauce, expirationDate: sauce.batchDate.addingTimeInterval(259200), freshnessStatus: .fresh)
}
