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
        var documents: [DocumentSnapshot] = []
        do {
            let snapshot = try await (query ?? collectionReference).getDocuments()
            documents = snapshot.documents
        } catch {
            throw FirebaseClientError.operationFailed(error)
        }
        
        return documents
    }
    
    public func document(_ id: String) -> DocumentReferenceWrapper {
        return DocumentReferenceWrapper(documentRef: collectionReference.document(id))
    }
    
    public func whereField(_ field: String, isEqualTo value: Any) -> QueryReference {
        let newQuery = collectionReference.whereField(field, isEqualTo: value)
        return QueryReference(collectionReference: collectionReference, query: newQuery)
    }
    
    public func order(by: String, descending: Bool = false) -> QueryReference {
        let newQuery = collectionReference.order(by: `by`, descending: descending)
        return QueryReference(collectionReference: collectionReference, query: newQuery)
    }
    
    
}
