//
//  FirebaseSauceRepository.swift
//  DataService
//
//  Created by Jireh Cordova on 24/11/2025.
//

import Foundation
import Models
import FirebaseServices

public actor FirebaseSauceRepository: SauceRepositoryProtocol {
    private let firebaseClient: FirebaseClient
    private let collectionName = "sauce"
    
    public init(firebaseClient: FirebaseClient = .shared) {
        self.firebaseClient = firebaseClient
    }
    
    // TODO: Review implementation
    public func fetchAll() async throws -> [Models.Sauce] {
        let records = try await firebaseClient
            .collection(collectionName)
            .order(by: "batchdate")
            .getDocuments()
        
        let sauces = records.compactMap { sauce in
            do {
                return try sauce.data(as: Sauce.self)
            } catch {
                return nil
            }
        }
        
        return sauces
    }
    
    public func fetch(id: String) async throws -> Models.Sauce? {
        let record = try await firebaseClient
            .collection(collectionName)
            .document(id)
            .getDocument()
        
        return try record.data(as: Sauce.self)
    }
    
    public func create(_ sauce: Models.Sauce) async throws -> Models.Sauce? {
        try await firebaseClient
            .collection(collectionName)
            .document(sauce.id)
            .setData(sauce)
                
        return sauce
    }
    
    public func update(_ sauce: Models.Sauce) async throws -> Models.Sauce? {
        try await firebaseClient
            .collection(collectionName)
            .document(sauce.id)
            .updateData([
                "name": sauce.name,
                "currentQuantity": sauce.currentQuantity,
                "unit": sauce.unit,
                "batchDate": sauce.batchDate,
            ])
        
        return sauce
    }
    
    public func delete(id: String) async throws {
        try await firebaseClient
            .collection(collectionName)
            .document(id)
            .delete()
    }
}
