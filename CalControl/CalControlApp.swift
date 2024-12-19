

import SwiftUI

@main
struct YourApp: App {

    @Environment(\.scenePhase) private var scenePhase  // To monitor app lifecycle state
    @StateObject private var appState: AppState

        init() {
            // Load the saved app state from UserDefaults if available
            if let savedAppState = AppState.loadFromUserDefaults() {
                _appState = StateObject(wrappedValue: savedAppState)
            } else {
                _appState = StateObject(wrappedValue: AppState()) // Create a new one if no data is saved
            }
        }

    var body: some Scene {
        WindowGroup {
            if (appState.username == "") {
                SetupScreenView()
            }
            else {
                MainMenuView(appState: appState)
            }
        
        }
    }
}
