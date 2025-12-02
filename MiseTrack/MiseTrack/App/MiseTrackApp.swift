//
//  MiseTrackApp.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 02/11/2025.
//

import SwiftUI
import FirebaseCore

@main
struct MiseTrackApp: App {
    @StateObject private var serviceContainer = ServiceContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(serviceContainer)
        }
    }
}
