import SwiftUI
import AVFoundation
let filePath = Bundle.main.path(forResource: "loginSound.mp3", ofType:nil)!
let fileUrl = URL(fileURLWithPath: filePath)
var bombSoundEffect: AVAudioPlayer?

struct SetupScreenView2: View {
    
    
    @ObservedObject var appState: AppState
    @State private var bmiRangeIndex: Int = 1
    @State private var willMoveToNextScreen = false
    let options = ["Loose weight", "Maintain weight", "Gain weight"]
    let bmiRanges = ["Underweight", "Normal", "Overweight", "Obese"]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimum = 0
        formatter.maximum = 300
        return formatter
    }()
    func updateBMIRange() {
        if appState.bmi < 18.5 {
                bmiRangeIndex = 0  // Underweight
        } else if appState.bmi >= 18.5 && appState.bmi < 24.9 {
                bmiRangeIndex = 1  // Normal
        } else if appState.bmi >= 25.0 && appState.bmi < 29.9 {
                bmiRangeIndex = 2  // Overweight
            } else {
                bmiRangeIndex = 3  // Obese
            }
        }
    
    var body: some View {
        NavigationView {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Your BMI is:")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text(String(appState.bmi))
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text("( " + bmiRanges[bmiRangeIndex] + " )")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("Select your goal:")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                HStack {
                    Spacer()
                    
                    VStack {
                        // Option 1: Loose weight
                        Text("⊖")
                            .foregroundColor(.white)
                            .font(.system(size: 70, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                        Text("Loose\nweight")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(appState.weightGoal == options[0] ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Toggle selection for Loose weight
                        if appState.weightGoal == options[0] {
                            appState.weightGoal = nil  // Deselect if already selected
                        } else {
                            appState.weightGoal = options[0]  // Select Loose weight
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        // Option 2: Maintain weight
                        Text("⊖")
                            .foregroundColor(.white)
                            .font(.system(size: 70, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                        Text("Maintain\nweight")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(appState.weightGoal == options[1] ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Toggle selection for Maintain weight
                        if appState.weightGoal == options[1] {
                            appState.weightGoal = nil  // Deselect if already selected
                        } else {
                            appState.weightGoal = options[1]  // Select Maintain weight
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        // Option 3: Gain weight
                        Text("⊕")
                            .foregroundColor(.white)
                            .font(.system(size: 70, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                        Text("Gain\nweight")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(appState.weightGoal == options[2] ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Toggle selection for Gain weight
                        if appState.weightGoal == options[2] {
                            appState.weightGoal = nil  // Deselect if already selected
                        } else {
                            appState.weightGoal = options[2]  // Select Gain weight
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
                Button(action: {
                    willMoveToNextScreen = true  // Set flag to true to trigger navigate()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)  // Rounded corners
                        .padding(.top, 30)  // Space from the options
                }
                .buttonStyle(PlainButtonStyle())  // Remove default button styling
                Spacer()
            }
        }.onAppear {
            playSound();
            updateBMIRange();  // Call the function when the view first appears
            
        }}.navigate(to: MainMenuView(appState: appState), when: $willMoveToNextScreen)
    }
}

struct SetupScreenView2_Previews: PreviewProvider {
    static var previews: some View {
        SetupScreenView2(appState: AppState())
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
