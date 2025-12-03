// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models
import DataService

public final class SauceService: SauceServicesProtocol {
    private let repository: SauceRepositoryProtocol
    
    public init(repository: SauceRepositoryProtocol? = nil) {
        if let repository {
            self.repository = repository
        } else {
            self.repository = DataService.shared.makeSauceRepository()
        }
    }
    
    public func getAllSauces() async throws -> [Sauce] {
        do {
            let sauces = try await repository.fetchAll()
            return sauces
        } catch {
            throw SauceServiceError.dataServiceError(error)
        }
    }
    
    public func getSauce(id: String) async throws -> Sauce {
        do {
            let sauce = try await repository.fetch(id: id)
            return sauce
        } catch {
            throw SauceServiceError.dataServiceError(error)
        }
    }
    
    public func createSauce(name: String,
                            currentQuantity: Double,
                            unit: Units,
                            batchDate: Date) async throws -> Sauce {
        
        guard !name.isEmpty else {
            throw SauceServiceError.invalidInput("Name cannot be empty")
        }
        
        let sauce = Sauce(id: UUID().uuidString,
                          name: name,
                          currentQuantity: currentQuantity,
                          unit: unit,
                          batchDate: batchDate)
        
        do {
            let sauce = try await repository.create(sauce)
            return sauce
        } catch {
            throw SauceServiceError.dataServiceError(error)
        }

    }
    
    public func updateSauceQuantity(id: String, currentQuantity: Double) async throws -> Sauce {
        
        let current = try await repository.fetch(id: id)
        let updated = Sauce(id: current.id,
                            name: current.name,
                            currentQuantity: currentQuantity,
                            unit: current.unit,
                            batchDate: current.batchDate)
        
        do {
            let sauce = try await repository.update(updated)
            return sauce
        } catch {
            throw SauceServiceError.dataServiceError(error)
        }
        
    }
    
    public func deleteSauce(id: String) async throws {
        do {
            try await repository.delete(id: id)
        } catch {
            throw SauceServiceError.dataServiceError(error)
        }
    }
    
    public func getQuantityStatus(for sauce: Models.Sauce, config: Models.BatchLimits) -> Models.QuantityStatus {
        let maxAmount = max(config.batchAmountLimitMl, 0.0001)
        let currentLevel = min(max(sauce.currentQuantity, 0), maxAmount)
        
        if currentLevel <= 0 {
            return .empty
        }
        
        if (currentLevel / maxAmount <= 0.5) {
            return .warning
        }
        
        return .stocked
    }
    
    public func getFreshnessStatus(for sauce: Models.Sauce, config: Models.BatchLimits) -> Models.FreshnessStatus {
        let now = Date()
        let oneDay: TimeInterval = 86_400
        let expirationDate = getExpirationDate(for: sauce, config: config)
        
        if now >= expirationDate {
            return .expired
        }
        
        if now >= expirationDate - oneDay {
            return .expiringSoon
        }
        
        return .fresh
    }
    
    public func getExpirationDate(for sauce: Models.Sauce, config: Models.BatchLimits) -> Date {
        let seconds: TimeInterval = config.batchExpirationInSeconds
        return sauce.batchDate.addingTimeInterval(seconds)
    }
}
