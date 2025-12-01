//
//  ConfigProviderProtocol.swift
//  ConfigService
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Foundation

public protocol ConfigProviderProtocol: Sendable {
    func fetchConfig() async throws
    func getBool(_ key: String) -> Bool
    func getString(_ key: String) -> String
    func getDouble(_ key: String) -> Double
    // func getConfig() -> AppConfig // Use for custom config object
}
