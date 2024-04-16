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
    private let stroke = StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .miter, dash: [5, 5])
    var FontysTQLocation = CLLocationCoordinate2D(latitude: 51.45153, longitude: 5.45335)
    var FontysR10Location = CLLocationCoordinate2D(latitude: 51.45126, longitude: 5.47962)
    @State private var isLoading = true
    
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
                
                if let route = viewModel.route {
                    MapPolyline(route.polyline)
                        .stroke(.red, style: stroke)
                }
            }
            .onAppear {
                isLoading = true
                fetchRouteAndTime()
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                    .controlSize(.large)
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
        }
    }
    
    private func fetchRouteAndTime() {
        Task {
            await viewModel.fetchRouteAndTime(to: FontysR10Location)
            isLoading = false
        }
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
