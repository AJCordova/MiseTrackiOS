//
//  ConfigProviderProtocol.swift
//  ConfigService
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Foundation

public protocol ConfigProviderProtocol: Sendable {
    func fetchConfig() async throws
    func getBool(_ key: ConfigKeys) -> Bool
    func getString(_ key: ConfigKeys) -> String
    func getDouble(_ key: ConfigKeys) -> Double
    // func getConfig() -> AppConfig // Use for custom config object
}
