//
//  SauceDetailsViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 26/11/2025.
//

import Foundation
import Models
import SauceServices
import RecipeServices

@MainActor
class SauceDetailsViewModel: ObservableObject {
    @Published var sauce: Sauce
    @Published var amount: Double = 0.00
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    private let service: SauceServicesProtocol
    
    public init(sauceService: SauceServicesProtocol, sauce: Sauce) {
        self.service = sauceService
        self.sauce = sauce
    }
    
    func consume() async throws {
        self.isLoading = true
        
        do {
            _ = try await self.service.updateSauceQuantity(id: self.sauce.id, currentQuantity: self.sauce.currentQuantity - self.amount)
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func delete() async throws {
        self.isLoading = true
        
        do {
            try await self.service.deleteSauce(id: self.sauce.id)
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
