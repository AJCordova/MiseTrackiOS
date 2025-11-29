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
    // TODO: sauce instance must only come from viewmodel.sauce
    private let sauceService: SauceServicesProtocol
    
    public init(sauceService: SauceServicesProtocol, sauce: Sauce) {
        self.sauceService = sauceService
        self.sauce = sauce
    }
    
    func consume() {
        let service = sauceService
        Task {
            do {
                _ = try await service.updateSauceQuantity(id: sauce.id,
                                                          currentQuantity: sauce.currentQuantity - amount)
            } catch {
                print("Error on sauce quantity update")
            }
        }
    }
    
    func delete() {
        let service = sauceService
        Task {
            do {
                try await service.deleteSauce(id: sauce.id)
            } catch {
                print("Error on sauce delete")
            }
        }
    }
}
