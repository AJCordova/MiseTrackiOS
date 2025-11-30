//
//  SauceListViewModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 25/11/2025.
//

import Foundation
import SauceServices
import Models

@MainActor
class SauceListViewModel: ObservableObject {
    @Published var sauces: [Sauce] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: SauceServicesProtocol
    
    public init(sauceService: SauceServicesProtocol) {
        self.service = sauceService
    }
    
    func loadSauces() {
        self.isLoading = true

        Task {
            do {
                let retrievedSauces = try await self.service.getAllSauces()
                let sorted = retrievedSauces.sorted { $0.batchDate < $1.batchDate }
                self.sauces = retrievedSauces
                self.isLoading = false
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
