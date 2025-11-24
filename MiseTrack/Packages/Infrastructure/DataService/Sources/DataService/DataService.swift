// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models

public final class DataService: Sendable {
    public static let shared = DataService()
    
    public func makeSauceRepository() -> SauceRepositoryProtocol {
        return FirebaseSauceRepository()
    }
}
