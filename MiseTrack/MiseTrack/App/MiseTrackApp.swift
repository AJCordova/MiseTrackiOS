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
    @StateObject private var services: ServiceContainer = ServiceContainer()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(services)
        }
    }
}
