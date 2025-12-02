//
//  SauceDetailsViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import Foundation
import Models
import SauceServices
import RecipeServices
import ConfigService

@MainActor
class SauceDetailsViewModel: ObservableObject {
    @Published var sauce: Sauce
    @Published var amount: Double = 0.00
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let sauceService: SauceServicesProtocol
    private let configService: ConfigProviderProtocol
    
    let batchLimits: BatchLimits
    
    public init(sauce: Sauce, sauceService: SauceServicesProtocol, configService: ConfigProviderProtocol) {
        self.sauceService = sauceService
        self.configService = configService
        self.sauce = sauce
        
        if let batchLimits = self.configService.getJSON(.batchLimits, as: BatchLimits.self) {
            self.batchLimits = batchLimits
        } else {
            self.batchLimits = BatchLimits(batchAmountLimitMl: 1000, batchExpirationInSeconds: 259200)
        }
    }
    
    func consume() async throws {
        self.isLoading = true
        
        do {
            _ = try await self.sauceService.updateSauceQuantity(id: self.sauce.id, currentQuantity: self.sauce.currentQuantity - self.amount)
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func delete() async throws {
        self.isLoading = true
        
        do {
            try await self.sauceService.deleteSauce(id: self.sauce.id)
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func getExpirationDate() -> Date {
        let seconds: TimeInterval = self.batchLimits.batchExpirationInSeconds
        return sauce.batchDate.addingTimeInterval(seconds)
    }
    
    func getFreshStatus() -> FreshnessStatus {
        let now = Date()
        let oneDay: TimeInterval = 86_400
        let expirationDate = getExpirationDate()
        
        if now >= expirationDate {
            return .expired
        }
        
        if now >= expirationDate - oneDay {
            return .expiringSoon
        }
        
        return .fresh
    }
    
    func getQuantityStatus() -> QuantityStatus {
        let maxAmount = max(self.batchLimits.batchAmountLimitMl, 0.0001)
        let currentLevel = min(max(sauce.currentQuantity, 0), maxAmount)
        
        if currentLevel <= 0 {
            return .empty
        }
        
        if (currentLevel / maxAmount <= 0.5) {
            return .warning
        }
        
        return .stocked
    }
}
