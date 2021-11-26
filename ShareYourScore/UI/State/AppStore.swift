//
//  State.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 26/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//
import SwiftUI

// An object that keeps track of the app state
// In here we set the prefered initial state of the app

class AppStore: ObservableObject {
    @Published var currentView: AppViewType = .microphone
    @Published var speechServiceStatus: SpeechServiceStatus = .unauthorized
    @Published var spokenScore: Int? = nil
}

enum SpeechServiceStatus {
    case unauthorized
    case ready
    case listening
    case error
}
