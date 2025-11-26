//
//  SauceServiceError.swift
//  SauceServices
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation

public enum SauceServiceError: LocalizedError {
    case notFound
    case invalidInput(String)
    case unknown(Error)
    
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "Sauce not found"
        case .invalidInput(let message):
            return "Invalid input: \(message)"
        case .unknown(let error):
            return "Error: \(error.localizedDescription)"
        }
    }
}
