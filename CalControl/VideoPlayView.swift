import SwiftUI
import AVKit

struct ExerciseTutorialView: View {
    @ObservedObject var appState: AppState
    @State private var willMoveToNextScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    let player = AVPlayer(url: Bundle.main.url(forResource: "ExerciseTutorial", withExtension: "mp4")!)
    let playerViewController = AVPlayerViewController()
    
    init(appState: AppState) {
        playerViewController.player = player
        self.appState = appState;
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                .edgesIgnoringSafeArea(.top)
            
            Spacer()
            
            Button(action: {
                    willMoveToNextScreen = true
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
        .navigate(to: ActivityScreen2(appState: appState), when: $willMoveToNextScreen)
        
    }
}

struct ExerciseTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTutorialView(appState: AppState())
    }
}
