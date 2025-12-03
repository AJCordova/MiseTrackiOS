//
//  RecipeServiceError.swift
//  RecipeServices
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation

public enum RecipeServiceError: LocalizedError {
    case notFound
    case invalidInput(String)
    case dataServiceError(Error)
    
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "Recipe not found"
        case .invalidInput(let message):
            return "Invalid input: \(message)"
        case .dataServiceError(let error):
            return "Data Repository error: \(error.localizedDescription)"
        }
    }
}
