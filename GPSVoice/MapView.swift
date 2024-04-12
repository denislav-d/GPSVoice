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
    @ObservedObject var viewModel: GPSViewModel
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var route: MKRoute?
    @State private var travelTime: String?
    private let stroke = StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .miter, dash: [5, 5])
    var FontysTQLocation = CLLocationCoordinate2D(latitude: 51.45153, longitude: 5.45335)
    var FontysR10Location = CLLocationCoordinate2D(latitude: 51.45126, longitude: 5.47962)
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                UserAnnotation()
                
                Annotation("Fontys ICT TQ", coordinate: FontysTQLocation, anchor: .bottom) {
                    Image(systemName:"building.2")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                        .foregroundStyle(.white)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                MapPolygon(coordinates: CLLocationCoordinate2D.FontysTQPolygonCoordinates)
                    .foregroundStyle(.blue.opacity(0.70))
                
                Annotation("Fontys R10", coordinate: FontysR10Location, anchor: .bottom) {
                    Image(systemName:"building")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                        .foregroundStyle(.white)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                MapPolygon(coordinates: CLLocationCoordinate2D.FontysR10PolygonCoordinates)
                    .foregroundStyle(.blue.opacity(0.70))
                
                if let route = route {
                    MapPolyline(route.polyline)
                        .stroke(.red, style: stroke)
                }
            }
            .onAppear {
                fetchRouteFrom(viewModel.currentLocation ?? CLLocationCoordinate2D(latitude: 51.44140, longitude: 547695), to: FontysR10Location)
            }

            
            if let travelTime = travelTime {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Travel time: \(travelTime)")
                            .padding()
                            .font(.headline)
                            .foregroundStyle(.black)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .padding()
                    }
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
        }
    }
    
    private func fetchRouteFrom(_ source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .walking
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            getTravelTime()
        }
    }
    
    private func getTravelTime() {
        guard let route = route else { return }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        travelTime = formatter.string(from: route.expectedTravelTime)
    }
}




extension CLLocationCoordinate2D {
    static let FontysTQPolygonCoordinates = [
        CLLocationCoordinate2D(latitude: 51.45145, longitude: 5.45274),
        CLLocationCoordinate2D(latitude: 51.45165, longitude: 5.45280),
        CLLocationCoordinate2D(latitude: 51.45149, longitude: 5.45407),
        CLLocationCoordinate2D(latitude: 51.45129, longitude: 5.45401),
        CLLocationCoordinate2D(latitude: 51.45130, longitude: 5.45390),
        CLLocationCoordinate2D(latitude: 51.45106, longitude: 5.45383),
        CLLocationCoordinate2D(latitude: 51.45108, longitude: 5.45361),
        CLLocationCoordinate2D(latitude: 51.45132, longitude: 5.45368)]
    
    static let FontysR10PolygonCoordinates = [
        CLLocationCoordinate2D(latitude: 51.45112, longitude: 5.48030),
        CLLocationCoordinate2D(latitude: 51.45111, longitude: 5.47891),
        CLLocationCoordinate2D(latitude: 51.45140, longitude: 5.47901),
        CLLocationCoordinate2D(latitude: 51.45140, longitude: 5.48018),
        CLLocationCoordinate2D(latitude: 51.45131, longitude: 5.48018),
        CLLocationCoordinate2D(latitude: 51.45131, longitude: 5.48026),
        CLLocationCoordinate2D(latitude: 51.45121, longitude: 5.48027),
        CLLocationCoordinate2D(latitude: 51.45121, longitude: 5.48030)]
}



//
//#Preview {
//    MapView()
//}
