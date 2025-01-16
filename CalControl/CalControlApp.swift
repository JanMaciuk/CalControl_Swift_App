import SwiftUI

@main
struct YourApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var appState: AppState
    
    init() {
            var username: String = ""
            var weight: Int = 0
            var height: Int = 0

            if let usernameArg = ProcessInfo.processInfo.arguments.first(where: { $0.starts(with: "--username=") })?.split(separator: "=").last {
                username = String(usernameArg)
            }

            if let weightArg = ProcessInfo.processInfo.arguments.first(where: { $0.starts(with: "--weight=") })?.split(separator: "=").last,
               let weightValue = Int(weightArg) {
                weight = weightValue
            }

            if let heightArg = ProcessInfo.processInfo.arguments.first(where: { $0.starts(with: "--height=") })?.split(separator: "=").last,
               let heightValue = Int(heightArg) {
                height = heightValue
            }

            // Obliczanie BMI, jeśli są dostępne waga i wysokość
            let bmi: Float = (weight > 0 && height > 0) ? Float(weight) / ((Float(height) / 100) * (Float(height) / 100)) : 0.0


            // Ustawienie appState na podstawie danych
            if !username.isEmpty || weight > 0 || height > 0 {
                _appState = StateObject(wrappedValue: AppState(username: username, weight: weight, height: height, bmi: bmi))
            } else if let savedAppState = AppState.loadFromUserDefaults() {
                _appState = StateObject(wrappedValue: savedAppState)
            } else {
                _appState = StateObject(wrappedValue: AppState())
            }
        }
    
//    init() {
//        if let savedAppState = AppState.loadFromUserDefaults() {
//            _appState = StateObject(wrappedValue: savedAppState)
//        } else {
//            _appState = StateObject(wrappedValue: AppState())
//        }
//    }
    
    
    
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
