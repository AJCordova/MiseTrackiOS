//
//  SauceServicesProtocol.swift
//  SauceServices
//
//  Created by Jireh Cordova on 22/11/2025.
//

import Foundation
import Models
import DataService

public protocol SauceServicesProtocol {
    func getAllSauces() async throws -> [Sauce]
    func getSauce(id: String) async throws -> Sauce
    func createSauce(name: String, currentQuantity: Double, unit: String, batchDate: Date) async throws -> Sauce
    func updateSauceQuantity(id: String, currentQuantity: Double) async throws -> Sauce
    func deleteSauce(id: String) async throws
}
