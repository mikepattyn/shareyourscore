import SwiftUI
import AppKit

struct ContentView: View {
    @State var statusText: String = "PopupScreenStatusInitial"~
    @ObservedObject var appStore: AppStore = AppStore()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("PopupScreenTitle"~)
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
            getViewFor($appStore.currentView.projectedValue.wrappedValue)
                .environmentObject(appStore)
            .padding(.bottom, 30)
            
            HStack {
                Text(statusText)
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

fileprivate func getViewFor(_ appView: AppViewType) -> AnyView {
    switch appView {
        case .microphone:
            return AnyView(MicrophoneView())
        case .score:
            return AnyView(ScoreView())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(statusText: "PopupScreenStatusInitial"~)
    }
}
