//
//  ContentView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(){
            NavigatorView()
                .tabItem { Label("Navigator", systemImage: "location.north")
                }
            
            StatsView()
                .tabItem { Label("Stats", systemImage: "list.bullet.clipboard.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
