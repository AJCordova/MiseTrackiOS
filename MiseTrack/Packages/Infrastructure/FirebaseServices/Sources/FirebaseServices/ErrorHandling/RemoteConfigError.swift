//
//  RemoteConfigError.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Firebase
import Foundation

public enum RemoteConfigError: LocalizedError {
    case configNotFetched
    case invalidValue(String)
    case decodingFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .configNotFetched:
            return "Remote config has not been fetched."
        case .invalidValue(let key):
            return "Invalid value for key: \(key)"
        case .decodingFailed(let error):
            return "Failed to decode config: \(error.localizedDescription)"
        }
    }
}

