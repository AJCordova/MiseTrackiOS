//
//  SauceDTO.swift
//  SauceServices
//
//  Created by Jireh Cordova on 22/11/2025.
//

import Foundation
import Models

public struct SauceDTO: Codable, Identifiable {
    public let id: String
    let name: String
    let batchDate: Date?
    var currentQuantity: Double
    var unit: String
    
    public init(id: String = UUID().uuidString, name: String, batchDate: Date?, currentQuantity: Double, unit: String) {
        self.id = id
        self.name = name
        self.batchDate = batchDate
        self.currentQuantity = currentQuantity
        self.unit = unit
    }
    
    public func toDomain() -> Sauce {
        Sauce(id: id,
              name: name,
              currentQuantity: currentQuantity,
              unit: unit,
              batchDate: batchDate,
              status: "" // should check if current quantity is under threshhold (remote config) or batchdata not exceeding storage time limit (remote config)
        )
    }
}
