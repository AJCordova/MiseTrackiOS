//
//  SauceListViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation
import SauceServices
import ConfigService
import Models

@MainActor
class SauceListViewModel: ObservableObject {
    @Published var sauces: [Sauce] = []
    @Published var isLoading = false
    @Published var showError = false
    
    var errorMessage: String? = nil
    
    private let sauceService: SauceServicesProtocol
    private let configService: ConfigProviderProtocol
    private let batchLimits: BatchLimits
    
    public init(sauceService: SauceServicesProtocol, configService: ConfigProviderProtocol) {
        self.sauceService = sauceService
        self.configService = configService
        
        if let batchLimits = self.configService.getJSON(.batchLimits, as: BatchLimits.self) {
            self.batchLimits = batchLimits
        } else {
            self.batchLimits = BatchLimits(batchAmountLimitMl: 1000, batchExpirationInSeconds: 259200)
        }
    }
    
    func loadSauces() {
        self.isLoading = true

        Task {
            do {
                let retrievedSauces = try await self.sauceService.getAllSauces()
                let sorted = retrievedSauces.sorted { $0.batchDate > $1.batchDate }
                self.sauces = sorted
                self.isLoading = false
                self.errorMessage = nil
            } catch {
                self.presentThrownError(error)
            }
        }
    }
    
    func getExpirationDate(for sauce: Sauce) -> Date {
        return self.sauceService.getExpirationDate(for: sauce, config: batchLimits)
    }
    
    func getFreshStatus(for sauce: Sauce) -> FreshnessStatus {
        return self.sauceService.getFreshnessStatus(for: sauce, config: batchLimits)
    }
    
    func getQuantityStatus(for sauce: Sauce) -> QuantityStatus {
        return self.sauceService.getQuantityStatus(for: sauce, config: batchLimits)
    }
    
    private func presentThrownError(_ error: Error) {
        self.isLoading = false
        self.errorMessage = error.localizedDescription
        self.showError = true
    }
}
