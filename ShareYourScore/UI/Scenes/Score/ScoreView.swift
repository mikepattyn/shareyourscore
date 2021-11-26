//
//  ScoreView.swift
//  ShareYourScore
//
//  Created by Mike Pattyn on 26/11/2021.
//  Copyright © 2021 Mike Pattyn. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    // Here we get the appStore that was added to the environment in the parent view
    @EnvironmentObject var appStore: AppStore
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Text("180")
                    .font(Font.system(size: 100.0))
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
                HStack {
                    Button(action: {
                        print("Score cancelled.")
                        appStore.currentView = .microphone
                    }) {
                        Text("Cancel").frame(width: 120, height: 40)
                    }.buttonStyle(BlueButtonStyle())
                    
                    Button(action: {
                        print("Score confirmed.")
                        appStore.currentView = .microphone
                    }) {
                        Text("Confirm").frame(width: 120, height: 40)
                    }.buttonStyle(BlueButtonStyle())
                }
            }
            Spacer()
        }.frame(height: 240)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
