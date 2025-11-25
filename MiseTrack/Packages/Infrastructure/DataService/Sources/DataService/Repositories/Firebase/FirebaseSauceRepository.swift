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
    
    public func fetchAll() async throws -> [Sauce] {
        let records = try await firebaseClient
            .collection(collectionName)
            .order(by: "batchdate")
            .getDocuments()
        
        let sauces = try records.map { record in
            try record.data(as: Sauce.self)
        }
        
        return sauces
    }
    
    public func fetch(id: String) async throws -> Sauce {
        let record = try await firebaseClient
            .collection(collectionName)
            .document(id)
            .getDocument()
        
        return try record.data(as: Sauce.self)
    }
    
    public func create(_ sauce: Sauce) async throws -> Sauce {
        try await firebaseClient
            .collection(collectionName)
            .document(sauce.id)
            .setData(sauce)
                
        return sauce
    }
    
    public func update(_ sauce: Sauce) async throws -> Sauce {
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
