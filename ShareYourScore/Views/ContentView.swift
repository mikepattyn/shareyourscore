import SwiftUI
import AppKit

class LocalizedStrings {
    var dictionary: Dictionary<String, String> = [:]
}
struct ContentView: View {
    @State var statusText: String = ""
    @State var isListening: Bool = false
    @State var spokenScore: Int = -1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(NSLocalizedString("PopupScreenTitle", comment: ""))
                    .font(Font.system(size: 34.0))
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
                Image(systemName: "xmark")
                    .frame(alignment: .topTrailing)
                    .padding(22)
                    .onTapGesture {
                        NSApplication.shared.terminate(self)
                    }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            
            HStack {
                Spacer()
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .frame(width: 240, height: 240, alignment: .center)
                    .onTapGesture {
                        print("Microphone tapped")
                        isListening = !isListening
                        
                    }
                    .foregroundColor(isListening ? .red : .white)
                Spacer()
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Click the microphone and speak your score")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom, 30)
        }
        .padding(0)
        .frame(width: 360.0, alignment: .top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(statusText: "")
    }
}
