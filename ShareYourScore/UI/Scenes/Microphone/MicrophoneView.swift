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
    @State var active: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "mic.circle.fill")
                .resizable()
                .frame(width: 240, height: 240, alignment: .center)
                .onTapGesture {
                    print("Microphone tapped")
                    appStore.speechServiceStatus = .loading
                    appStore.currentView = .score
                }
                .foregroundColor(active ? .red : .white)
            Spacer()
        }.onAppear {
            print("Current appStore.currentView: \(appStore.currentView)")
        }
    }
}

struct MicrophoneView_Previews: PreviewProvider {
    static var previews: some View {
        MicrophoneView()
    }
}
