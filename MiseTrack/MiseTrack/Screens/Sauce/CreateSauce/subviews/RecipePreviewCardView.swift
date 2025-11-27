//
//  RecipePreviewCard.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 27/11/2025.
//

import Foundation
import SwiftUI
import Models

struct RecipePreviewCardView: View {
    let recipe: Recipe
    let scale: Double
    let isSelected: Bool
    let onSelect: () -> Void
    let onDeselect: () -> Void
    
    var scaledYield: Double {
        recipe.volumeMl * scale
    }
    
    public init(recipe: Recipe,
                scale: Double,
                isSelected: Bool,
                onSelect: @escaping () -> Void,
                onDeselect: @escaping () -> Void) {
        self.recipe = recipe
        self.scale = scale
        self.isSelected = isSelected
        self.onSelect = onSelect
        self.onDeselect = onDeselect
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(recipe.displayName)
                        .font(.headline)
                    Text("Yield: \(String(format: "%.2f", recipe.volumeMl)) ml")
                        .font(.caption)
                        .foregroundStyle(.secondaryText)
                }
                
                Spacer()
                
//                if isSelected {
//                    Image(systemName: "checkmark.circle.fill")
//                        .foregroundStyle(.green)
//                        .font(.title2)
//                }
                if isSelected {
                    Button(action: onDeselect) {
                        Text("Deselect")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.red.opacity(0.1))
                            .foregroundStyle(.red)
                            .cornerRadius(4)
                    }
                } else {
                    Button(action: onSelect) {
                        Text("Select")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundStyle(.blue)
                            .cornerRadius(4)
                    }
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Ingredients (x\(String(format: "%.1f", scale)))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                ForEach(recipe.ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .font(.caption)
                        Spacer()
                        Text("\(String(format: "%.1f", ingredient.quantity)) \(ingredient.unit)")
                            .font(.caption)
                            .foregroundStyle(.second)
                    }
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Scaled Yield")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(String(format: "%.0f", scaledYield)) ml")
                }
            }
        }
        .padding()
        .background(isSelected ? Color.green.opacity(0.05) : .divider.opacity(0.3))
        .border(isSelected ? Color.green : Color(.systemGray6),
                width: 1)
//        .cornerRadius(8)
    }
}

