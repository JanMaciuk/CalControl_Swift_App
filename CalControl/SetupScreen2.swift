import SwiftUI

struct SetupScreenView2: View {
    @State var bmi: Float = 20.0
    @State var bmiRangeIndex: Int = 1
    let bmiRanges = ["Underweight", "Normal", "Overweight", "Obese"]
    
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
                Spacer()
                Text("Your BMI is:")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text(String(bmi))
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
                    
                    Spacer()
                    VStack {
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
                    Spacer()
                    VStack {
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
                    Spacer()
                }
                

                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}

struct SetupScreenView2_Previews: PreviewProvider {
    static var previews: some View {
        SetupScreenView2()
    }
}
