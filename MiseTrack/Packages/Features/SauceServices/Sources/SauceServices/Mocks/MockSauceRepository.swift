//
//  MockSauceRepository.swift
//  DataService
//
//  Created by Jireh Cordova on 02/12/2025.
//

import Foundation
import Models
import DataService

public actor MockSauceRepository: SauceRepositoryProtocol {
    private var sauces: [Sauce] = []
    
    public init(sauces: [Sauce] = MockData.sauces) {
        self.sauces = sauces
    }
    
    public func fetchAll() async throws -> [Sauce] {
        return sauces.sorted { $0.batchDate > $1.batchDate }
    }
    
    public func fetch(id: String) async throws -> Sauce {
        guard let sauce = sauces.first(where: {
            $0.id == id
        }) else {
            throw SauceServiceError.notFound
        }
        
        return sauce
    }
    
    public func create(_ sauce: Sauce) async throws -> Sauce {
        let sauce = Sauce(id: "3",
                          name: "new sauce",
                          currentQuantity: 3000,
                          unit: .milliliter,
                          batchDate: Date())
        sauces.append(sauce)
        return sauce
    }
    
    public func update(_ sauce: Sauce) async throws -> Sauce {
        var sauce = sauces[0]
        sauce.currentQuantity = sauce.currentQuantity - 100
        return sauce
    }
    
    public func delete(id: String) async throws {
        guard let index = sauces.firstIndex(where: {
            $0.id == id
        }) else {
            throw SauceServiceError.notFound
        }
        
        sauces.remove(at: index)
    }
}
