//
//  FirebaseRemoteConfigProvider.swift
//  ConfigService
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Foundation
import FirebaseServices

public final class FirebaseRemoteConfigProvider: ConfigProviderProtocol {
    
    private let remoteConfigClient: RemoteConfigClient
    
    init(remoteConfigClient: RemoteConfigClient = .shared) {
        self.remoteConfigClient = remoteConfigClient
    }
    
    public func fetchConfig() async throws {
        try await remoteConfigClient.fetchAndActivate()
    }
    
    public func getBool(_ key: ConfigKeys) -> Bool {
        remoteConfigClient.getBool(key.rawValue)
    }
    
    public func getString(_ key: ConfigKeys) -> String {
        remoteConfigClient.getString(key.rawValue)
    }
    
    public func getDouble(_ key: ConfigKeys) -> Double {
        remoteConfigClient.getDouble(key.rawValue)
    }}
