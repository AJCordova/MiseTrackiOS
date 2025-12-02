// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class ConfigService: Sendable {
    public static let shared = ConfigService()
    
    public func initConfigService() -> ConfigProviderProtocol {
        return FirebaseRemoteConfigProvider()
    }
}
