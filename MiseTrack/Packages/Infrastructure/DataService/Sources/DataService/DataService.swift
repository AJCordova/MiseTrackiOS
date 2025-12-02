// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class DataService: Sendable {
    public static let shared = DataService()
    
    public func makeSauceRepository() -> SauceRepositoryProtocol {
        return FirebaseSauceRepository()
    }
    
    public func makeRecipeRepository() -> RecipeRepositoryProtocol {
        return FirebaseRecipeRepository()
    }
}
