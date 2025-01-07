//
import SwiftUI
import AVFoundation
let filePath = Bundle.main.path(forResource: "loginSound.mp3", ofType:nil)!
let fileUrl = URL(fileURLWithPath: filePath)
var bombSoundEffect: AVAudioPlayer?

struct LoadingView: View {
    @ObservedObject var appState: AppState
    @State private var isAnimating = true
    @State private var willMoveToNextScreen = false
        
        var body: some View {
            VStack {

                ProgressView("Loading")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                
                Text("getting ready for you")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                playSound();
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    willMoveToNextScreen = true
                }
            }.navigate(to: MainMenuView(appState: appState), when: $willMoveToNextScreen)
        }
}

struct LoadinAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(appState: AppState())
    }
}

func playSound() {
    do {
        bombSoundEffect = try AVAudioPlayer(contentsOf: fileUrl)
        bombSoundEffect?.play()
    } catch {
        // couldn't load file :(
    }
}
