//
//  DocumentReferenceWrapper.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 24/11/2025.
//

import Foundation
import FirebaseFirestore


public struct DocumentReferenceWrapper {
    private let documentRef: DocumentReference
    
    init(documentRef: DocumentReference) {
        self.documentRef = documentRef
    }
    
    public func getDocument() async throws -> DocumentSnapshot {
        do {
            return try await documentRef.getDocument()
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
    
    public func setData<T: Encodable>(_ data: T) async throws {
        let encoded: [String: Any]
        
        do {
            encoded = try Firestore.Encoder().encode(data)
        } catch {
            throw FirebaseClientError.encodingFailed(error)
        }
        
        do {
            try await documentRef.setData(encoded)
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
    
    public func updateData<T: Encodable>(_ data: T) async throws {
        let encoded: [String: Any]
        
        do {
            encoded = try Firestore.Encoder().encode(data)
        } catch {
            throw FirebaseClientError.encodingFailed(error)
        }
        
        do {
            try await documentRef.updateData(encoded)
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
    
    public func updateData(_ data: [String: Any]) async throws {
        do {
            try await documentRef.updateData(data)
            // add logging
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
        
    public func delete() async throws {
        do {
            try await documentRef.delete()
            // add logging
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
}
