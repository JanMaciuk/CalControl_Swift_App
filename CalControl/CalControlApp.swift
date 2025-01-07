import SwiftUI

@main
struct YourApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var appState: AppState
    
    init() {
        if let savedAppState = AppState.loadFromUserDefaults() {
            _appState = StateObject(wrappedValue: savedAppState)
        } else {
            _appState = StateObject(wrappedValue: AppState())
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.username == "" {
                SetupScreenView()
            } else {
                MainMenuView(appState: appState)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                appState.saveToUserDefaults()
            }
        }
    }
}
