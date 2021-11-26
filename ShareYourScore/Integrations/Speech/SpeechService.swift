//
//  SpeechService.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 25/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//

import Foundation
import AVKit
import Speech
import SwiftUI

class SpeechService: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private var speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer()
    private var speechRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    @Published private(set) var speechResult: String = String.empty
    
    override init() {
        super.init()
        speechSynthesizer.delegate = self
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        speechSynthesizer.speak(utterance)
    }
    
    var isAuthorized: Bool { return SFSpeechRecognizer.authorizationStatus() == .authorized }

    func startRecording() throws {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            //            handleError(withMessage: "Speech recognizer not available")
            return
        }
        
        self.speechRequest.shouldReportPartialResults = true
        
        recognizer.recognitionTask(with: speechRequest, resultHandler: { result, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let result = result else { print("No result"); return }
            print("Got a new result: \(result.bestTranscription.formattedString)")
            print(result.isFinal ? "Result is final" : "Result isn't final")
            if result.isFinal {
                self.speechResult = result.bestTranscription.formattedString
            }
        })
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.speechRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    func stopRecording() {
        recognitionTask?.finish()
        //        recognitionTask = nil
        speechRequest.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}

