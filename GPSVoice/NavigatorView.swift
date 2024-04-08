//
//  NavigatorView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI
import CoreMotion


struct NavigatorView: View {
    @State private var isVoiceEnabled = false
    @State private var traveledDistance: Double = 0
    @State private var lastLocation: CLLocation?
    
    var body: some View {
        NavigationStack {
            VStack {
                MapView(traveledDistance: $traveledDistance, lastLocation: $lastLocation)
                
                VStack {
                    HStack{
                        Text("Total Distance Traveled:")
                        Spacer()
                        Text("\(String(format: "%.1f", traveledDistance)) meters")
                            .bold()
                    }
                    .padding(.horizontal)
                    
                    Toggle("Enable Voice Feedback", isOn: $isVoiceEnabled)
                        .padding(.horizontal)
                        .onChange(of: isVoiceEnabled) {
                            // Handle voice feedback enabling/disabling
                        }
                }
                .padding(.vertical)
            }
        }
    }
}

//#Preview {
//    NavigatorView()
//}
