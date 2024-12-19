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
    @Published var kcal_burned: Int = 0
    @Published var kcal_change_date: Date? = nil
    @Published var intensivity = [
        ("high",1),
        ("medium", 0.75),
        ("low",0.5)
    ]
    @Published var activity: [(activity:String, kcal_per_hour: Int)] = [
        (activity:"Running",kcal_per_hour:200),
        (activity:"Cycling",kcal_per_hour:260),
        (activity:"Waking",kcal_per_hour:100),
        (activity:"Swimming",kcal_per_hour:400),
        (activity:"Gym", kcal_per_hour:450),
        (activity:"Studing",kcal_per_hour:250)
    ]
    
    @Published var today_activity: [(activity: String, interval: Date, kcal: Int)] = []
    
    @Published var sleep_history: [(went:Date,wake:Date,interval:(Int,Int))] = []

    
//    init() {
//        self.today_activity = [
//            (activity: "Running", interval: createDateWithTime(hour: 1, minute: 20), kcal: 201),
//            (activity: "Cycling", interval: createDateWithTime(hour: 0, minute: 30), kcal: 123),
//            (activity: "Other", interval: createDateWithTime(hour: 1, minute: 15), kcal: 201),
//            (activity: "Other2", interval: createDateWithTime(hour: 2, minute: 52), kcal: 201)
//        ]
//    }
//    
    // Kuba G 2:
    @Published var kcal_consumed: Int = 0
    
      

    func calculateBMI() {
        // Ensure height and weight are non-nil before calculating BMI
        guard let weight = weight, let height = height else {
            self.bmi = 0.0  // Default to 0 if either height or weight is nil
            return
        }
        let heightInMeters = Float(height) / 100.0
        self.bmi = Float(weight) / (heightInMeters * heightInMeters)
    }
    
    func resetKcalories(){
        //reset kcalories at the end of the day
        
        if(kcal_change_date != nil){
            let kcal_date_tmp: Date = kcal_change_date ?? Date()
            let calendar = Calendar.current
            
            let components1 = calendar.dateComponents([.year, .month, .day], from: kcal_date_tmp)
            let components2 = calendar.dateComponents([.year, .month, .day], from: Date())
            
            guard let normalizedDate1 = calendar.date(from: components1),
                  let normalizedDate2 = calendar.date(from: components2) else {
                return
            }
            if(normalizedDate1 != normalizedDate2){
                kcal_burned = 0
            }
        }
        
    }
    
    func createDateWithTime(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        
        if let dateWithTime = calendar.date(from: dateComponents) {
            return dateWithTime
        } else {
            return currentDate
        }
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
