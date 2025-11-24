//
//  FirebaseSauceRepository.swift
//  DataService
//
//  Created by Jireh Cordova on 24/11/2025.
//

import Foundation
import Models
import FirebaseServices

public actor FirebaseSauceRepository: SauceRepositoryProtocol {
    private let firebaseClient: FirebaseClient
    private let collectionName = "sauce"
    
    public init(firebaseClient: FirebaseClient = .shared) {
        self.FirebaseClient = firebaseClient
    }
    
    
}
