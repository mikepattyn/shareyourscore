//
//  SpeechController.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 25/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

protocol SpeechServiceProtocol {
    func checkPermission() -> SFSpeechRecognizerAuthorizationStatus
    func requestAuthorization(_ completionHandler: @escaping SpeechCompletionHandler) -> Void    
    func listen(completion: @escaping (String) -> Void) throws
}

typealias SpeechCompletionHandler = (SFSpeechRecognizerAuthorizationStatus) -> Void

class SpeechService: ObservableObject, SpeechServiceProtocol {
    @Published var detectedText: String? = nil
    private let speechRecognizer = SFSpeechRecognizer()
    private var speechRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    internal func checkPermission() -> SFSpeechRecognizerAuthorizationStatus {
        return SFSpeechRecognizer.authorizationStatus()
    }
    
    func requestAuthorization(_ completionHandler: @escaping SpeechCompletionHandler) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            completionHandler(authStatus)
        }
    }
    
    func listen(completion: @escaping (String) -> Void) throws {
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
                DispatchQueue.main.async {
                    completion(result.bestTranscription.formattedString)
                }
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
}
