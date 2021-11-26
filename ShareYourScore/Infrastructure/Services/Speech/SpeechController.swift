//
//  SpeechController.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 25/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//

import Foundation
import Speech
import SwiftUI

class SpeechController {
    var speechRecognizer: SFSpeechRecognizer!
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
                case .authorized:
                    
                    break
                default:
                    break
            }
        }
    }
}
