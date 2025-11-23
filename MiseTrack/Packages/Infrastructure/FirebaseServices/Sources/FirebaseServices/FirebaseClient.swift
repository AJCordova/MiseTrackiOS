// The Swift Programming Language
// https://docs.swift.org/swift-book

import Firebase

public actor FirebaseClient: Sendable {
    public static let shared = FirebaseClient()
    
    private let db: Firestore = Firestore.firestore()
    public init() {
        
    }
}
