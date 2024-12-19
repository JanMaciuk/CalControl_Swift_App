import SwiftUI
import Foundation
import Combine

extension AppState {
    // Save AppState to UserDefaults
    func saveToUserDefaults() {
        print("Started saving appstate")
        do {
            // Try to encode the AppState object into data
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            
            // Save the data to UserDefaults
            UserDefaults.standard.set(data, forKey: "AppState")
        } catch {
            print("Failed to save AppState: \(error)")
        }
    }
    
    // Load AppState from UserDefaults
    static func loadFromUserDefaults() -> AppState? {
        print("Started loading appstate")
        if let data = UserDefaults.standard.data(forKey: "AppState") {
            do {
                // Decode the data into AppState object
                let decoder = JSONDecoder()
                let appState = try decoder.decode(AppState.self, from: data)
                return appState
            } catch {
                print("Failed to load AppState: \(error)")
            }
        }
        return nil
    }
}


class AppState: ObservableObject, Codable {
    private var cancellables: Set<AnyCancellable> = []
    init() {
            // Listen for when the app goes into the background
            NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
                .sink { _ in
                    self.saveToUserDefaults()
                }
                .store(in: &cancellables)
        }

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
    @Published var intensivity: [(String, Double)] = [
        ("high", 1),
        ("medium", 0.75),
        ("low", 0.5)
    ]
    @Published var activity: [(String, Int)] = [
        ("Running", 200),
        ("Cycling", 260),
        ("Walking", 100),
        ("Swimming", 400),
        ("Gym", 450),
        ("Studying", 250)
    ]
    
    @Published var today_activity: [(activity: String, interval: Date, kcal: Int)] = []

    // Kuba G 2:
    @Published var kcal_consumed: Int = 0

    func calculateBMI() {
        guard let weight = weight, let height = height else {
            self.bmi = 0.0
            return
        }
        let heightInMeters = Float(height) / 100.0
        self.bmi = Float(weight) / (heightInMeters * heightInMeters)
    }
    
    func resetKcalories() {
        if let kcal_change_date = kcal_change_date {
            let calendar = Calendar.current
            let components1 = calendar.dateComponents([.year, .month, .day], from: kcal_change_date)
            let components2 = calendar.dateComponents([.year, .month, .day], from: Date())
            
            guard let normalizedDate1 = calendar.date(from: components1),
                  let normalizedDate2 = calendar.date(from: components2) else {
                return
            }
            if normalizedDate1 != normalizedDate2 {
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
        return calendar.date(from: dateComponents) ?? currentDate
    }
    
    // MARK: - Codable Support
    enum CodingKeys: String, CodingKey {
        case username, birthDate, height, weight, selectedGender, activityLevel, bmi, weightGoal
        case kcal_burned, kcal_change_date, intensivity, activity, today_activity, kcal_consumed
    }

    // MARK: - Encode and Decode
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the structured data (as structs)
        let decodedIntensivity = try container.decode([Intensity].self, forKey: .intensivity)
        let decodedActivity = try container.decode([Activity].self, forKey: .activity)
        let decodedTodayActivity = try container.decode([TodayActivity].self, forKey: .today_activity)

        // Convert structs back to tuples
        self.intensivity = decodedIntensivity.map { ($0.intensity, $0.multiplier) }
        self.activity = decodedActivity.map { ($0.activity, $0.kcal_per_hour) }
        self.today_activity = decodedTodayActivity.map { ($0.activity, $0.interval, $0.kcal) }

        // Other properties
        username = try container.decode(String.self, forKey: .username)
        birthDate = try container.decode(Date.self, forKey: .birthDate)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        selectedGender = try container.decodeIfPresent(String.self, forKey: .selectedGender)
        activityLevel = try container.decode(String.self, forKey: .activityLevel)
        bmi = try container.decode(Float.self, forKey: .bmi)
        weightGoal = try container.decodeIfPresent(String.self, forKey: .weightGoal)
        kcal_burned = try container.decode(Int.self, forKey: .kcal_burned)
        kcal_change_date = try container.decodeIfPresent(Date.self, forKey: .kcal_change_date)
        kcal_consumed = try container.decode(Int.self, forKey: .kcal_consumed)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Convert tuples back to structs for encoding
        let intensivityForEncoding = intensivity.map { Intensity(intensity: $0.0, multiplier: $0.1) }
        let activityForEncoding = activity.map { Activity(activity: $0.0, kcal_per_hour: $0.1) }
        let todayActivityForEncoding = today_activity.map { TodayActivity(activity: $0.activity, interval: $0.interval, kcal: $0.kcal) }

        // Encode the structured data (as structs)
        try container.encode(intensivityForEncoding, forKey: .intensivity)
        try container.encode(activityForEncoding, forKey: .activity)
        try container.encode(todayActivityForEncoding, forKey: .today_activity)

        // Encode other properties
        try container.encode(username, forKey: .username)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(selectedGender, forKey: .selectedGender)
        try container.encode(activityLevel, forKey: .activityLevel)
        try container.encode(bmi, forKey: .bmi)
        try container.encodeIfPresent(weightGoal, forKey: .weightGoal)
        try container.encode(kcal_burned, forKey: .kcal_burned)
        try container.encodeIfPresent(kcal_change_date, forKey: .kcal_change_date)
        try container.encode(kcal_consumed, forKey: .kcal_consumed)
    }
}

// Structs for custom encoding/decoding
struct Activity: Codable {
    let activity: String
    let kcal_per_hour: Int
}

struct Intensity: Codable {
    let intensity: String
    let multiplier: Double
}

struct TodayActivity: Codable {
    let activity: String
    let interval: Date
    let kcal: Int
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
