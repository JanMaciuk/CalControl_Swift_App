import SwiftUI

class AppState: ObservableObject {
    // Janek:
    @Published var username: String = ""
    @Published var birthDate = Date()
    @Published var height: Int? = nil // Height in centimeters (optional)
    @Published var weight: Int? = nil // Weight in kilograms (optional)
    @Published var selectedGender: String? = nil
    @Published var activityLevel = "Medium"
    @Published var bmi: Float = 10.0 // Default BMI is 10
    @Published var weightGoal: String? = nil
    
    // Kuba 1:
    
    
    // Kuba 2:
    
    


    func calculateBMI() {
        print("Started calculate BMI")
        // Ensure height and weight are non-nil before calculating BMI
        guard let weight = weight, let height = height else {
            self.bmi = 0.0  // Default to 0 if either height or weight is nil
            return
        }
        print("Guard Passed")
        

        let heightInMeters = Float(height) / 100.0
        

        self.bmi = Float(weight) / (heightInMeters * heightInMeters)
        print(bmi)

    }
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
