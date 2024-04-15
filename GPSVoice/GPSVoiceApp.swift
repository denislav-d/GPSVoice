//
//  GPSVoiceApp.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI

@main
struct GPSVoiceApp: App {
    @StateObject private var viewModel = GPSViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
