// The Swift Programming Language
// https://docs.swift.org/swift-book

import Firebase
import Foundation
import Models

public actor FirebaseClient: Sendable {
    public static let shared: FirebaseClient()
    private let db = Firestore.firestore()
    
    public init(){}
    
}
