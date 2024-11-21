import SwiftUI

struct SetupScreenView: View {
    @State var username: String = ""
    @State var selectedDate = Date()
    @State var height: Int? = nil
    @State var weight: Int? = nil
    @State private var activityLevel = "Medium"
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
                Text("♀")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .semibold))
                    .padding(.bottom, 20)
                Spacer()
                Text("♂")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .semibold))
                    .padding(.bottom, 20)
                Spacer()
            }
            
            //Text boxes:
            VStack(alignment: .leading, spacing: 2) {
                Text("Username:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Text",
                    text: $username,
                    prompt: Text("Enter your username")
                )
                .foregroundColor(.black).background(.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Birth date:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                DatePicker(
                    "Choose your date of birth:",
                    selection: $selectedDate,
                    displayedComponents: .date
                ).background(.white).foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Height:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Your height in cm",
                    value: $height,
                    formatter: numberFormatter
                )
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: height) { newValue in
                    if let number = newValue, number < 0 {
                        self.height = 0
                    }
                }.foregroundColor(.black).background(.white)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 2) {
                Text("Weight")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                TextField(
                    "Your weight in kg",
                    value: $weight,
                    formatter: numberFormatter
                )
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: weight) { newValue in
                    if let number = newValue, number < 0 {
                        self.weight = 0
                    }
                }.foregroundColor(.black).background(.white)
            }
            Spacer()
            VStack(spacing: 2) {
                Text("Your typical activity level:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                Picker("Select an option", selection: $activityLevel) {
                    ForEach(activityLevels, id: \.self) { option in Text(option) }
                }.background(.white)
            }
            Spacer()
                    
            NavigationLink(
                destination: MainMenuView(),
                label: {
                    Text("Go to Second View")
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .frame(width: UIScreen.main.bounds.width * 0.8) // does not work correctly
                        .font(.system(size: 20, weight: .semibold))
                }
            )
                        
            //End of view
            Spacer()
                    
            }
        }
    }
}


struct SetupScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SetupScreenView()
    }
}
