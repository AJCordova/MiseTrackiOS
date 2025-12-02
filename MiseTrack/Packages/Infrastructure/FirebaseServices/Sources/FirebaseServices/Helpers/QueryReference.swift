//
//  QueryReference.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 23/11/2025.
//

import Firebase

public struct QueryReference {
    private let collectionReference: CollectionReference
    private let query: Query?
    
    init(collectionReference: CollectionReference, query: Query? = nil) {
        self.collectionReference = collectionReference
        self.query = query
    }
    
    public func getDocuments() async throws -> [DocumentSnapshot] {
        do {
            let snapshot = try await (query ?? collectionReference).getDocuments()
            return snapshot.documents
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
    }
    
    public func document(_ id: String) -> DocumentReferenceWrapper {
        return DocumentReferenceWrapper(documentRef: collectionReference.document(id))
    }
    
    public func whereField(_ field: String, isEqualTo value: Any) -> QueryReference {
        let base: Query = query ?? collectionReference
        let newQuery = base.whereField(field, isEqualTo: value)
        return QueryReference(collectionReference: collectionReference, query: newQuery)
    }
    
    public func order(by field: String, descending: Bool = false) -> QueryReference {
        let base: Query = query ?? collectionReference
        let newQuery = base.order(by: field, descending: descending)
        return QueryReference(collectionReference: collectionReference, query: newQuery)
    }
    
    public func limit(to limit: Int) -> QueryReference {
        let base: Query = query ?? collectionReference
        let newQuery = base.limit(to: limit)
        return QueryReference(collectionReference: collectionReference, query: newQuery)
    }
}
