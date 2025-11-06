//
//  SaucesView.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI

struct SaucesView: View {
    
    @State var saucesList = []
    @ViewBuilder
    var body: some View {
        ZStack {
            Color.base.ignoresSafeArea(edges: .top)
            VStack {
                if saucesList.isEmpty {
                    EmptyListView(listName: "sauces")
                }
            }
        }
    }
}

#Preview {
    SaucesView()
}
