import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover.init()
    var statusBar: StatusBarController?
    @ObservedObject var appStore: AppStore = AppStore()
    @ObservedObject var speechService: SpeechService = SpeechService()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()
            .environmentObject(appStore)
            .environmentObject(speechService)
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentViewController = MainViewController()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        // Create the Status Bar Item with the Popover
        statusBar = StatusBarController.init(popover)
        
        // Check speech recongnitation authorization and request it if we dont have it yet
        if speechService.checkPermission() != .authorized {
            speechService.requestAuthorization { authStatus in
                if authStatus == .authorized {
                    self.appStore.speechServiceStatus = .ready
                }
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

