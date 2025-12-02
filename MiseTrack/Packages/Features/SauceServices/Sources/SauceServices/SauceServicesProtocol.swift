//
//  SauceServicesProtocol.swift
//  SauceServices
//
//  Created by Jireh Cordova on 22/11/2025.
//

import Foundation
import Models
import DataService

public protocol SauceServicesProtocol: Sendable {
    func getAllSauces() async throws -> [Sauce]
    func getSauce(id: String) async throws -> Sauce
    func createSauce(name: String, currentQuantity: Double, unit: Units, batchDate: Date) async throws -> Sauce
    func updateSauceQuantity(id: String, currentQuantity: Double) async throws -> Sauce
    func deleteSauce(id: String) async throws
    
    //
    func getQuantityStatus(for sauce: Sauce, config: BatchLimits) -> QuantityStatus
    func getFreshnessStatus(for sauce: Sauce, config: BatchLimits) -> FreshnessStatus
    func getExpirationDate(for sauce: Sauce, config: BatchLimits) -> Date
}
