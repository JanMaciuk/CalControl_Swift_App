import SwiftUI

struct SetupScreenView: View {
    @ObservedObject var appState = AppState()
    @State private var willMoveToNextScreen = false
    let activityLevels = ["Low", "Medium", "High"]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimum = 0
        formatter.maximum = 300
        return formatter
    }()
    
    var body: some View {
        ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack {
            //Headers:
            Spacer()
            Text("Welcome to the first step to calorie balance")
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
            Text("Fill in some of your information first")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .semibold))
                .padding(.bottom, 20)
            
            //Gender select
            Text("Gender:")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 20)
            HStack {
                Spacer()
                // Female symbol
                Text("♀")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .semibold))
                    .padding(.bottom, 20)
                    .padding()
                    .background(appState.selectedGender == "Female" ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Toggle the selected gender
                        if appState.selectedGender == "Female" {
                            appState.selectedGender = nil  // Deselect if already selected
                        } else {
                            appState.selectedGender = "Female"
                        }
                    }
                // End female symbol
                Spacer()
                
                // Male symbol
                Text("♂")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .semibold))
                    .padding(.bottom, 20)
                    .padding()
                    .background(appState.selectedGender == "Male" ? Color.gray : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Toggle the selected gender
                        if appState.selectedGender == "Male" {
                            appState.selectedGender = nil  // Deselect if already selected
                        } else {
                            appState.selectedGender = "Male"
                        }
                    }
                // End male symbol
                Spacer()
            }
            
            //Text boxes:
            VStack(alignment: .leading, spacing: 2) {
                Text("Username:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Text",
                    text: $appState.username,
                    prompt: Text("Enter your username")
                )
                .foregroundColor(.black).background(.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Birth date:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                DatePicker(
                    "Choose your date of birth:",
                    selection: $appState.birthDate,
                    displayedComponents: .date
                ).background(.white).foregroundColor(.gray).cornerRadius(15)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Height:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Your height in cm",
                    value: $appState.height,
                    formatter: numberFormatter
                )
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: appState.height) { newValue in
                    if let number = newValue, number < 0 {
                        appState.height = 0
                    }
                }.foregroundColor(.black).background(.white).cornerRadius(15)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Weight")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Your weight in kg",
                    value: $appState.weight,
                    formatter: numberFormatter
                )
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: appState.weight) { newValue in
                    if let number = newValue, number < 0 {
                        appState.weight = 0
                    }
                }.foregroundColor(.black).background(.white).cornerRadius(15)
            }
            Spacer()
            VStack(spacing: 2) {
                Text("Your typical activity level:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                Picker("Select an option", selection: $appState.activityLevel) {
                    ForEach(activityLevels, id: \.self) { option in Text(option) }
                }.background(.white).cornerRadius(15)
            }
            Spacer()
            

            Button(action: {
                if (appState.username != "" && appState.height != nil && appState.weight != nil && appState.selectedGender != nil) {
                    appState.calculateBMI()
                    willMoveToNextScreen = true  // Set flag to true to trigger navigate()
                }
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
                        
            
            //End of view
            Spacer()
                
            }}.navigate(to: SetupScreenView2(appState: appState), when: $willMoveToNextScreen)
        }
    }



struct SetupScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SetupScreenView()
    }
}
