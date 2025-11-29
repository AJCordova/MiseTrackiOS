//
//  SauceModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//
import Foundation

public struct Sauce: Identifiable, Codable, Sendable {
    public let id: String
    public let name: String
    public var currentQuantity: Double
    public var unit: Units
    public var batchDate: Date
    
    public init(id: String,
                name: String,
                currentQuantity: Double,
                unit: Units,
                batchDate: Date) {
        self.id = id
        self.name = name
        self.currentQuantity = currentQuantity
        self.unit = unit
        self.batchDate = batchDate
    }
}
