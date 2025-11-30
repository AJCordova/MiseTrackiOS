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
    private let sauceService: SauceServicesProtocol
    
    public init(sauceService: SauceServicesProtocol, sauce: Sauce) {
        self.sauceService = sauceService
        self.sauce = sauce
    }
    
    func consume() {
        let service = sauceService
        isLoading = true
        Task {
            do {
                _ = try await service.updateSauceQuantity(id: sauce.id,
                                                          currentQuantity: sauce.currentQuantity - amount)
                isLoading = false
            } catch {
                print("Error on sauce quantity update")
                isLoading = false
            }
        }
    }
    
    func delete() {
        let service = sauceService
        isLoading = true
        Task {
            do {
                try await service.deleteSauce(id: sauce.id)
                isLoading = false
            } catch {
                print("Error on sauce delete")
                isLoading = false
            }
        }
    }
}
