//
//  EmptyListView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 06/11/2025.
//

import SwiftUI

public struct EmptyListView: View {
    let listName: String
    public var body: some View {
        VStack {
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.secondaryText)
                    .symbolEffect(.bounce.up.wholeSymbol, options: .nonRepeating)
                Text("No \(listName) available")
                    .foregroundStyle(Color.secondaryText)
                    .font(.system(size: 15.0, weight: .medium))
            }
        }
    }
}

#Preview {
    EmptyListView(listName: "sauces")
}
