import SwiftUI

struct AddActivity: View {
    @ObservedObject var appState: AppState
    @State private var activity_name = ""
    @State private var kcal_per_hour = 0
    
    @State private var isLinkActive = false
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimum = 1
        formatter.maximum = 300
        return formatter
    }()
    
    private var isFormValid: Bool {
        return !activity_name.isEmpty && kcal_per_hour > 0
    }
    
    func updateAppState() {
        appState.activity.append((activity: activity_name, kcal_per_hour: kcal_per_hour))
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: ActivityScreen2(appState: appState)
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true), isActive: $isLinkActive) {
                        ChevronLeft()
                    }
                    Spacer()
                    Text("Add custom activity")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack {
                    Text("Activity name")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Activity name", text: $activity_name)
                        .padding(.leading, 10)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack {
                    Text("Kcal per hour")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Kcal per hour", value: $kcal_per_hour, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                        .padding(.leading, 10)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Spacer()
                
                NavigationLink(
                    destination: ActivityScreen2(appState: appState).navigationBarHidden(true).navigationBarBackButtonHidden(true),
                    isActive: $isLinkActive,
                    label: {
                        Text("Add new activity")
                            .padding()
                            .background(isFormValid ? Color.white : Color.gray)
                            .foregroundColor(isFormValid ? .black : .gray)
                            .clipShape(Capsule())
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .font(.system(size: 20, weight: .semibold))
                    }
                )
                .disabled(!isFormValid)
                .onChange(of: isLinkActive) { newValue in
                    if newValue {
                        updateAppState()
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct AddActivity_Preview: PreviewProvider {
    static var previews: some View {
        AddActivity(appState: AppState())
    }
}
