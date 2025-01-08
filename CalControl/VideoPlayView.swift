import SwiftUI
import AVKit

struct ExerciseTutorialView: View {
    @ObservedObject var appState: AppState
    @State private var willMoveToNextScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    let player = AVPlayer(url: Bundle.main.url(forResource: "ExerciseTutorial", withExtension: "mp4")!)
    let playerViewController = AVPlayerViewController()
    
    init(appState: AppState) {
        // Initialize the player with the video URL
        playerViewController.player = player
        self.appState = appState;
    }
    
    var body: some View {
        VStack {
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
                    .cornerRadius(30)
                    .padding(.top, 30)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .navigate(to: MainMenuView(appState: appState), when: $willMoveToNextScreen)
        
    }
}

struct ExerciseTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTutorialView(appState: AppState())
    }
}
