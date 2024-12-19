import SwiftUI
import AVKit

struct ExerciseTutorialView: View {
    @ObservedObject var appState: AppState
    @State private var willMoveToNextScreen = false
    @Environment(\.presentationMode) var presentationMode  // To handle the back action
    
    let player = AVPlayer(url: Bundle.main.url(forResource: "ExerciseTutorial", withExtension: "mp4")!)
    let playerViewController = AVPlayerViewController()
    
    init(appState: AppState) {
        // Initialize the player with the video URL
        playerViewController.player = player
        self.appState = appState;
    }
    
    var body: some View {
        VStack {
            // Embed the video player
            VideoPlayer(player: player)
                .onAppear {
                    player.play()  // Play the video as soon as the view appears
                }
                .onDisappear {
                    player.pause()  // Pause the video when the view disappears
                }
                .edgesIgnoringSafeArea(.top)
            
            Spacer()
            
            // Back button at the bottom
            Button(action: {
                    willMoveToNextScreen = true  // Set flag to true to trigger navigate()
            }) {
                Text("Go back")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)  // Rounded corners
                    .padding(.top, 30)  // Space from the options
            }
            .buttonStyle(PlainButtonStyle())  // Remove default button styling
            
        }
        .background(Color.black)  // Black background
        .edgesIgnoringSafeArea(.all)  // Full screen
        .navigate(to: MainMenuView(appState: appState), when: $willMoveToNextScreen)
        
    }
}

struct ExerciseTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTutorialView(appState: AppState())
    }
}
