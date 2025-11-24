//
//  DocumentSnapshot.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 24/11/2025.
//
import FirebaseFirestore
import Foundation

extension DocumentSnapshot {
    public func data<T: Decodable>(as type: T.Type) throws -> T {
        guard let data = self.data() else {
            throw FirebaseClientError.documentNotFound
        }
        
        do {
            return try Firestore.Decoder().decode(type, from: data)
        } catch {
            throw FirebaseClientError.decodingFailed(error)
        }
    }
}
