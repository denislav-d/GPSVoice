//
//  NavigatorView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI
import CoreLocation
import AVFoundation

struct NavigatorView: View {
    @ObservedObject private var viewModel = GPSViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                MapView(viewModel: viewModel)
                
                VStack {
                    HStack {
                        Text("Total Distance Traveled:")
                        Spacer()
                        withAnimation {
                            Text("\(String(format: "%.1f", viewModel.traveledDistance)) meters")
                                .bold()
                                .animation(.default)
                                .contentTransition(.numericText())
                        }
                    }
                    
                    Toggle("Enable Voice Feedback", isOn: $viewModel.isVoiceEnabled)
                }
                .padding()
            }
        }
    }
}


#Preview {
    NavigatorView()
}
