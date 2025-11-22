//
//  SauceRepositoryProtocol.swift
//  SauceServices
//
//  Created by Jireh Cordova on 22/11/2025.
//

public protocol SauceRepositoryProtocol: Sendable {
    func fetchAll() async throws -> [SauceDTO]
    func fetch(id: String) async throws -> SauceDTO
    func create(_ sauce: SauceDTO) async throws -> SauceDTO
    func update(_ sauce: SauceDTO) async throws -> SauceDTO
    func delete(id: String) async throws
}
