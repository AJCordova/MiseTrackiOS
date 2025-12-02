//
//  UIApplication+Extensions.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 01/12/2025.
//
import UIKit

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
