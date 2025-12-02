import XCTest
@testable import SauceServices

final class SauceServicesTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testFetchSauces() async throws {
        let mockRepo = MockSauceRepository()
        let service = SauceService(repository: mockRepo)
        
        let sauces = try await service.getAllSauces()
        XCTAssertFalse(sauces.isEmpty)
    }
}
