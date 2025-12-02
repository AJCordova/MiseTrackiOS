//
//  ServiceContainer.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 01/12/2025.
//

import Foundation
import ConfigService

@MainActor
class ServiceContainer: ObservableObject {
    let configService: ConfigProviderProtocol
    
    init() {
        self.configService = ConfigService.shared.initConfigService()
        
        self.loadConfiguration()
    }
    
    private func loadConfiguration() {
        Task {
            do {
                try await configService.fetchConfig()
                print("Successfully fetched remote config.")
            } catch {
                print("Fetching remote config failed. Using default settings.")
            }
        }
    }
}
