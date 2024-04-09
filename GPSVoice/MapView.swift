//
//  MapView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 6.04.24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
        }
    }
}
//
//#Preview {
//    MapView()
//}
