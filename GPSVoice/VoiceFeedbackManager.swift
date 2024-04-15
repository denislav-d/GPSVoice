//
//  VoiceFeedbackManager.swift
//  GPSVoice
//
//  Created by Denislav Dimitrov on 15.04.24.
//

import AVFoundation

class VoiceFeedbackManager {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(message: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}
