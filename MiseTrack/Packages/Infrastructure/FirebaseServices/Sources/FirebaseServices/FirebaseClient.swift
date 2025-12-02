// The Swift Programming Language
// https://docs.swift.org/swift-book

@preconcurrency import Firebase

public final class FirebaseClient: Sendable {
    public static let shared = FirebaseClient()
    
    private let db: Firestore
    
    private init(firestore: Firestore = Firestore.firestore()) {
        self.db = firestore
    }
    
    public func collection(_ name: String) -> QueryReference {
        let collectionRef = db.collection(name)
        return QueryReference(collectionReference: collectionRef)
    }
}
