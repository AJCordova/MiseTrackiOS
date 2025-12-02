//
//  Encodable+Extension.swift
//  FirebaseServices
//
//  Created by Jireh Cordova on 02/12/2025.
//

import Foundation

public extension Encodable {
    func toJSONString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        
        guard let string = String(data: data, encoding: .utf8) else {
            throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: [], debugDescription: "Failed to convert data"))
        }
        
        return string
    }
}
