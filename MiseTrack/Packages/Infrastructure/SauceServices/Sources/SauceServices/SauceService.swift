// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models
import DataService

public class SauceService: SauceServicesProtocol {
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
    
    public func getSauce(id: UUID) async throws -> Sauce {
        return try await repository.fetch(id: id.uuidString)
    }
    
    public func createSauce(name: String, currentQuantity: Double, unit: String, batchDate: Date) async throws -> Sauce {
        
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
    
    public func updateSauceQuantity(id: UUID, currentQuantity: Double) async throws -> Sauce {
        
        let current = try await repository.fetch(id: id.uuidString)
        let updated = Sauce(id: current.id,
                            name: current.name,
                            currentQuantity: currentQuantity,
                            unit: current.unit,
                            batchDate: current.batchDate)
        
        return try await repository.update(updated)
    }
    
    public func deleteSauce(id: UUID) async throws {
        try await repository.delete(id: id.uuidString)
    }
}
