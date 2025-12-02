//
//  RemoteConfigClient.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 01/12/2025.
//

@preconcurrency import FirebaseRemoteConfig
import Models

public final class RemoteConfigClient: Sendable {
    public static let shared = RemoteConfigClient()
    
    private let remoteConfig: RemoteConfig
    
    public init(remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()) {
        self.remoteConfig = remoteConfig
        self.setupDefaults()
    }
    
    private nonisolated func setupDefaults() {
        let defaultBatchLimits: BatchLimits = BatchLimits(batchAmountLimitMl: 5000, batchExpirationInSeconds: 432000)
        let defaultProperties: [String: NSObject] = [
            "allow_recipe_edit": false as NSObject,
            "batch_expiration": 432000 as NSObject,
            "batch_limits": (try? defaultBatchLimits.toJSONString()) as? NSObject ?? "" as NSObject
        ]
        
        remoteConfig.setDefaults(defaultProperties)
    }
    
    public func fetchAndActivate() async throws {
        do {
            let expirationDuration: TimeInterval = 0 // always fresh for dev
            let _ = try await remoteConfig.fetch(withExpirationDuration: expirationDuration)
            try await remoteConfig.activate()
            
//            try await remoteConfig.fetchAndActivate()
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
    
    public func getJSON<T: Decodable>(_ key: String, as type: T.Type) -> T? {
        let jsonString = getString(key)
        
        guard !jsonString.isEmpty,
              let jsonData = jsonString.data(using: .utf8)
        else {
            return nil
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: jsonData)
            print("Decoded for key \(key): decoded")
            return decoded
        } catch {
            print("Failed to decode for key \(key): \(error.localizedDescription)")
            return nil
        }
    }
}
