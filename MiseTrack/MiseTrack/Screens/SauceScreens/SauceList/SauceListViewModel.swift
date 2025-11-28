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
    
    private let sauceService: SauceServicesProtocol
    
    init(sauceService: SauceServicesProtocol) {
        self.sauceService = sauceService
    }
    
    func loadSauces() {
        isLoading = true
        let service = sauceService

        Task {
            do {
                // TODO: Remove task execution delay for sync workaround.
                let sauces = try await service.getAllSauces()
                let sorted = sauces.sorted { $0.batchDate > $1.batchDate }
                
                await MainActor.run { [weak self] in
                    self?.sauces = sorted
                    self?.isLoading = false
                    self?.errorMessage = nil
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                }
            }
        }
    }
}
