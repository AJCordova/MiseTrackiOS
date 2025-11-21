//
//  SauceModel.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 21/11/2025.
//
import Foundation

struct Sauce: Identifiable, Codable {
    let id: String
    let name: String
    var currentQuantity: Double
    var unit: String
    var batchDate: Date?
    var status: String
}
