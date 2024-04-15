//
//  StatsView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 2.04.24.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: GPSViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("\(viewModel.allTimeDistance, specifier: "%.2f") meters")
                } header: {
                    Text("All time total distance travelled:")
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
