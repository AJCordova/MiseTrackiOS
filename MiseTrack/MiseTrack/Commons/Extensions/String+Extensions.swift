//
//  String+Extensions.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 28/11/2025.
//

extension String {
    func removingAllWhiteSpaceAndNewLines() -> String {
        self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    func removingWhiteSpaceAndNewLines() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
