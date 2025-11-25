//
//  SauceRepositoryProtocol.swift
//  DataService
//
//  Created by Jireh Cordova on 24/11/2025.
//

import Foundation
import Models

public protocol SauceRepositoryProtocol: Sendable {
    func fetchAll() async throws -> [Sauce]
    func fetch(id: String) async throws -> Sauce?
    func create(_ sauce: Sauce) async throws -> Sauce?
    func update(_ sauce: Sauce) async throws -> Sauce?
    func delete(id: String) async throws
}
