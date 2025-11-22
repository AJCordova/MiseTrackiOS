//
//  SauceRepositoryProtocol.swift
//  SauceServices
//
//  Created by Jireh Cordova on 22/11/2025.
//

import Models

public protocol SauceRepositoryProtocol: Sendable {
    func fetchAll() async throws -> [Sauce]
    func fetch(id: String) async throws -> SauceDTO
    
}
