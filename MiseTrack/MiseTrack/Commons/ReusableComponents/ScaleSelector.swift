//
//  ScaleSelector.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 27/11/2025.
//

import Foundation
import SwiftUI

struct ScaleSelector: View {
    @Binding var scale: Double
    private let scales: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Scale recipe:")
                .font(.headline)
            
            HStack(spacing: 8) {
                ForEach(scales, id: \.self) { scaleValue in
                    Button(action: { scale = scaleValue }) {
                        Text("x\(String(format: "%.0f", scaleValue))")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(scale == scaleValue ? Color.blue : Color(.systemGray6))
                            .foregroundStyle(scale == scaleValue ? .white : .primary)
                            .cornerRadius(6)
                    }
                }
            }
            
            HStack {
                Text("Current scale:")
                    .font(.caption)
                Spacer()
                Text("x\(String(format: "%.1f", scale))")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
