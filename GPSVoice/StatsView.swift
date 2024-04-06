//
//  StatsView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationStack {
            List() {
                Section {
                    Text("120 km")
                } header: {
                    Text("Total distance travelled:")
                }
                Section {
                    Text("26 hours")
                } header: {
                    Text("Total time spent using GPS Voice:")
                }
            } 
            .navigationTitle("Stats")
        }
   
    }
}

#Preview {
    StatsView()
}
