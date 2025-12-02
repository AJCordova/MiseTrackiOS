//
//  RemoteConfigClient.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 01/12/2025.
//

@preconcurrency import FirebaseRemoteConfig

public final class RemoteConfigClient: Sendable {
    public static let shared = RemoteConfigClient()
    
    private let remoteConfig: RemoteConfig
    
    public let defaultProperties: [String: NSObject] = [
        "allow_recipe_edit": false as NSObject,
        "batch_expiration": 432000 as NSObject
    ]
    
    public init(remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()) {
        self.remoteConfig = remoteConfig
        self.remoteConfig.setDefaults(self.defaultProperties)
    }
    
    public func fetchAndActivate() async throws {
        do {
//            let expirationDuration: TimeInterval = 0 // always fresh for dev
//            let _ = try await remoteConfig.fetch(withExpirationDuration: expirationDuration)
//            try await remoteConfig.activate()
            
            try await remoteConfig.fetchAndActivate()
        } catch {
            throw RemoteConfigError.configNotFetched
        }
    }
    
    public func getBool(_ key: String) -> Bool {
        return remoteConfig[key].boolValue
    }
    
    public func getString(_ key: String) -> String {
        return remoteConfig[key].stringValue
    }
    
    public func getDouble(_ key: String) -> Double {
        return remoteConfig[key].numberValue.doubleValue
    }
    
    // TODO: Create a config object? 
}
