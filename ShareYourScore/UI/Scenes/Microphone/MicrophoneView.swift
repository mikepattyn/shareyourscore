//
//  MicrophoneView.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 26/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//

import SwiftUI

struct MicrophoneView: View {
    @EnvironmentObject var appStore: AppStore
    @EnvironmentObject var speechService: SpeechService
    
    @State var isListening: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "mic.circle.fill")
                .resizable()
                .frame(width: 240, height: 240, alignment: .center)
                .onTapGesture {
                    print("Microphone tapped")
                    if speechService.checkPermission() != .authorized {
                        print("Faulty permissions")
                        return
                    }
                    isListening = !isListening
                    try? speechService.listen { resultText in
                        isListening = !isListening
                        if let score = Int(resultText) {
                            appStore.spokenScore = score
                            appStore.currentView = .score
                        }
                    }
                }
                .foregroundColor(isListening ? .red : .white)
            Spacer()
        }.onAppear {
            print("Current appStore.currentView: \(appStore.currentView)")
        }
    }
}

fileprivate func determinePermission(speechService: SpeechService) {
    if speechService.checkPermission() != .authorized {
        speechService.requestAuthorization { authStatus in
            
        }
    }
    
    speechService.requestAuthorization { authStatus in
        
    }
}

struct MicrophoneView_Previews: PreviewProvider {
    static var previews: some View {
        MicrophoneView()
    }
}
