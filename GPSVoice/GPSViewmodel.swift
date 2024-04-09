//
//  GPSViewmodel.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 9.04.24.
//

import Foundation
import CoreLocation
import AVFoundation
import Combine

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var traveledDistance: Double = 0 {
        didSet {
            if isVoiceEnabled && traveledDistance - lastDistanceSpoken >= 25 {
                speakDistance()
            }
        }
    }
    @Published var isVoiceEnabled: Bool = false
    
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
}
