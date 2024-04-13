//
//  GPSViewmodel.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 9.04.24.
//

import Foundation
import CoreLocation
import AVFoundation
import MapKit

class GPSViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var traveledDistance: Double = 0 {
        didSet {
            if isVoiceEnabled && traveledDistance - lastDistanceSpoken >= 25 {
                speakDistance()
            }
        }
    }
    @Published var isVoiceEnabled: Bool = false
    @Published var route: MKRoute?
    @Published var travelTime: String?

    private var lastLocation: CLLocation?
    private var lastDistanceSpoken: Double = 0
    private var voiceSynthesizer = AVSpeechSynthesizer()
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }

        if let last = lastLocation {
            let distance = last.distance(from: newLocation)
            traveledDistance += distance
        }

        lastLocation = newLocation
    }

    private func speakDistance() {
        let utterance = AVSpeechUtterance(string: "You have traveled \(Int(traveledDistance)) meters.")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        voiceSynthesizer.speak(utterance)
        lastDistanceSpoken = traveledDistance
    }

    var currentLocation: CLLocationCoordinate2D? {
        guard let location = lastLocation else { return nil }
        return CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }

    @MainActor func fetchRouteAndTime(to destination: CLLocationCoordinate2D) async {
        guard let source = currentLocation else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .walking

        do {
            let result = try await MKDirections(request: request).calculate()
            route = result.routes.first
            calculateTravelTime()
        } catch {
            print("Error fetching route: \(error)")
        }
    }

    private func calculateTravelTime() {
        guard let route = route else { return }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        travelTime = formatter.string(from: route.expectedTravelTime)
    }
}
