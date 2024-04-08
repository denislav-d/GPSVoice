//
//  MapView.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 6.04.24.
//

import SwiftUI
import CoreLocation
import MapKit

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    var mapView: MapView?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mapView = mapView,
              let newLocation = locations.last else { return }
        
        if let last = mapView.lastLocation {
            let distance = last.distance(from: newLocation)
            mapView.traveledDistance += distance
        }
        
        mapView.lastLocation = newLocation
    }
}

struct MapView: View {
    @Binding var traveledDistance: Double
    @Binding var lastLocation: CLLocation?
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    let locationManager = CLLocationManager()
    let delegate = LocationManagerDelegate()
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear {
            delegate.mapView = self
            locationManager.delegate = delegate
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

//
//#Preview {
//    MapView()
//}
