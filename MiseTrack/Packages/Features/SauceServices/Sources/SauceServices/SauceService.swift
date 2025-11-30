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
        return try await repository.fetchAll()
    }
    
    public func getSauce(id: String) async throws -> Sauce {
        return try await repository.fetch(id: id)
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
        
        return try await repository.create(sauce)
    }
    
    public func updateSauceQuantity(id: String, currentQuantity: Double) async throws -> Sauce {
        
        let current = try await repository.fetch(id: id)
        let updated = Sauce(id: current.id,
                            name: current.name,
                            currentQuantity: currentQuantity,
                            unit: current.unit,
                            batchDate: current.batchDate)
        
        return try await repository.update(updated)
    }
    
    public func deleteSauce(id: String) async throws {
        try await repository.delete(id: id)
    }
}
