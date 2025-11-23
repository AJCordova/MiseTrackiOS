// The Swift Programming Language
// https://docs.swift.org/swift-book

@preconcurrency import FirebaseFirestore
import Firebase

public struct DataService: Sendable {
    
    private let db: Firestore
    public init() async {
        self.db = Firestore.firestore()
        do {
            let _ = try await firestoreTest()
        } catch {
            print("Error on firestoreTest")
        }
    }
    
    private func firestoreTest() async throws {
        do {
            let snapshot = try await db.collection("Sauce").getDocuments()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
            }
        } catch {
            print("Error reading document")
        }
    }
    
}
