//
//  SaucesView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI

struct SaucesView: View {
    var body: some View {
        ZStack {
            Color.base.ignoresSafeArea(edges: .top)
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundStyle(Color.secondaryText)
                    .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
                Text("No sauces available")
                    .foregroundStyle(Color.secondaryText)
                    .font(.system(size: 15.0, weight: .medium))
            }
        }
    }
}

#Preview {
    SaucesView()
}
