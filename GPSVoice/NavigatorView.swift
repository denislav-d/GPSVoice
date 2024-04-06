//
//  NavigatorView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI


struct NavigatorView: View {
    @State private var isVoiceEnabled = false
    @State private var traveledDistance: Double = 0
    
    var body: some View {
        NavigationStack {
            MapView()
            
            VStack {
                HStack{
                    Text("Total Distance Traveled:")
                    Spacer()
                    withAnimation {
                        Text("\(String(format: "%.1f", traveledDistance)) meters")
                            .animation(.default)
                            .contentTransition(.numericText())
                            .bold()
                    }
                   
                }
                .padding(.horizontal)
                
                Toggle("Enable Voice Feedback", isOn: $isVoiceEnabled)
                    .padding(.horizontal)
                    .onChange(of: isVoiceEnabled) {
                        if isVoiceEnabled {
                           //
                        } else {
                            //
                        }
                    }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    NavigatorView()
}
