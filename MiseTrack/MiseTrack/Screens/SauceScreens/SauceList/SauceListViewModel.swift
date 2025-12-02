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
    @Published var errorMessage: String?
    
    private let sauceService: SauceServicesProtocol
    private let configService: ConfigProviderProtocol
    private let batchLimits: BatchLimits
    
    public init(sauceService: SauceServicesProtocol, configService: ConfigProviderProtocol) {
        self.sauceService = sauceService
        self.configService = configService
        
        if let batchLimits = self.configService.getJSON(.batchLimits, as: BatchLimits.self) {
            self.batchLimits = batchLimits
            print(self.batchLimits.batchAmountLimitMl)
        } else {
            self.batchLimits = BatchLimits(batchAmountLimitMl: 1000, batchExpirationInSeconds: 259200)
        }
    }
    
    func loadSauces() {
        self.isLoading = true

        Task {
            do {
                let retrievedSauces = try await self.sauceService.getAllSauces()
                let sorted = retrievedSauces.sorted { $0.batchDate < $1.batchDate }
                self.sauces = sorted
                self.isLoading = false
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func getExpirationDate(for sauce: Sauce) -> Date {
        let seconds: TimeInterval = self.batchLimits.batchExpirationInSeconds
        return sauce.batchDate.addingTimeInterval(seconds)
    }
    
    func getFreshStatus(for sauce: Sauce) -> FreshnessStatus {
        let now = Date()
        let oneDay: TimeInterval = 86_400
        let expirationDate = getExpirationDate(for: sauce)
        
        if now >= expirationDate {
            return .expired
        }
        
        if now >= expirationDate - oneDay {
            return .expiringSoon
        }
        
        return .fresh
    }
}
