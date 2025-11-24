//
//  FirebaseClientError.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 24/11/2025.
//

import Firebase
import Foundation

public enum FirebaseClientError: LocalizedError {
    case documentNotFound
    case decodingFailed(Error)
    case encodingFailed(Error)
    case operationFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .documentNotFound:
            return "Document not found"
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .encodingFailed(let error):
            return "Encoding failed: \(error.localizedDescription)"
        case .operationFailed(let error):
            return "Operation failed: \(error.localizedDescription)"
        }
    }
}
