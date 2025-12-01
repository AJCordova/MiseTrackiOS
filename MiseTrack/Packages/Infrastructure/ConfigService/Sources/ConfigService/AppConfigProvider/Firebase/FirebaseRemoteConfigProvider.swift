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
    
    public func getBool(_ key: String) -> Bool {
        remoteConfigClient.getBool(key)
    }
    
    public func getString(_ key: String) -> String {
        remoteConfigClient.getString(key)
    }
    
    public func getDouble(_ key: String) -> Double {
        remoteConfigClient.getDouble(key)
    }}
