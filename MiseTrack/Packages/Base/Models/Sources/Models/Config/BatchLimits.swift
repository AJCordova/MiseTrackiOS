//
//  BatchLimits.swift
//  Models
//
//  Created by Jireh Cordova on 02/12/2025.
//

public struct BatchLimits: Codable, Sendable {
    public let batchAmountLimitMl: Double
    public let batchExpirationInSeconds: Double
    
    enum CodingKeys: String, CodingKey {
        case batchAmountLimitMl = "batch_amount_limit_ml"
        case batchExpirationInSeconds = "batch_expiration_in_seconds"
    }
    
    public init(batchAmountLimitMl: Double, batchExpirationInSeconds: Double) {
        self.batchAmountLimitMl = batchAmountLimitMl
        self.batchExpirationInSeconds = batchExpirationInSeconds
    }
}
