//
//  SauceModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//
import Foundation

public struct Sauce: Identifiable, Codable {
    public let id: String
    public let name: String
    public var currentQuantity: Double
    public var unit: String
    public var batchDate: Date?
    public var status: String
    
    public init(id: String, name: String, currentQuantity: Double, unit: String, batchDate: Date? = nil, status: String) {
        self.id = id
        self.name = name
        self.currentQuantity = currentQuantity
        self.unit = unit
        self.batchDate = batchDate
        self.status = status
    }
}
