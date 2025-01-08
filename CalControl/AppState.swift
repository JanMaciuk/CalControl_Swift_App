import SwiftUI
import Foundation
import Combine
import UIKit

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

struct Product: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageName: String?
    let kcalPer100g: Double
    let proteinPer100g: Double
    let carbsPer100g: Double
    let fatPer100g: Double
}

struct EatenMeal: Identifiable, Codable {
    let id = UUID()
    let product: Product
    let grams: Double
    let dateEaten: Date
    
    var totalKcal: Double {
        (grams / 100.0) * product.kcalPer100g
    }
    var totalProtein: Double {
        (grams / 100.0) * product.proteinPer100g
    }
    var totalCarbs: Double {
        (grams / 100.0) * product.carbsPer100g
    }
    var totalFat: Double {
        (grams / 100.0) * product.fatPer100g
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
        dailyResetIfNeeded()
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
    @Published var allProducts: [Product] = [
        Product(name: "Parówki (Berlinki)",
                imageName: "parowki_berlinki",
                kcalPer100g: 260, proteinPer100g: 11, carbsPer100g: 5, fatPer100g: 21),
        Product(name: "Ryż",
                imageName: "ryz",
                kcalPer100g: 350, proteinPer100g: 7, carbsPer100g: 78, fatPer100g: 1),
        Product(name: "Jabłko (Polskie)",
                imageName: "jablko_polskie",
                kcalPer100g: 52, proteinPer100g: 0.3, carbsPer100g: 14, fatPer100g: 0.2),
        Product(name: "Masło (Łaciate)",
                imageName: "maslo_laciate",
                kcalPer100g: 720, proteinPer100g: 1, carbsPer100g: 0, fatPer100g: 81),
        Product(name: "Pierś z kurczaka",
                imageName: "piers_kurczaka",
                kcalPer100g: 165, proteinPer100g: 31, carbsPer100g: 0, fatPer100g: 3.6),
        Product(name: "Makaron (Barilla)",
                imageName: "makaron_barilla",
                kcalPer100g: 370, proteinPer100g: 13, carbsPer100g: 77, fatPer100g: 1.5),
        Product(name: "Bułka pszenna",
                imageName: "bulka_pszenna",
                kcalPer100g: 280, proteinPer100g: 9, carbsPer100g: 57, fatPer100g: 2),
        Product(name: "Chleb żytni",
                imageName: "chleb_zytni",
                kcalPer100g: 220, proteinPer100g: 6, carbsPer100g: 40, fatPer100g: 1.5),
        Product(name: "Ser żółty (Gouda)",
                imageName: "ser_zolty_gouda",
                kcalPer100g: 350, proteinPer100g: 27, carbsPer100g: 2.2, fatPer100g: 26),
        Product(name: "Szynka konserwowa (Krakus)",
                imageName: "szynka_krakus",
                kcalPer100g: 120, proteinPer100g: 18, carbsPer100g: 1, fatPer100g: 4),
        Product(name: "Banany",
                imageName: "banany",
                kcalPer100g: 89, proteinPer100g: 1.1, carbsPer100g: 23, fatPer100g: 0.3),
        Product(name: "Pomidor (Malinowy)",
                imageName: "pomidor_malinowy",
                kcalPer100g: 18, proteinPer100g: 0.9, carbsPer100g: 3.9, fatPer100g: 0.2),
        Product(name: "Cebula",
                imageName: "cebula",
                kcalPer100g: 40, proteinPer100g: 1.1, carbsPer100g: 9, fatPer100g: 0.1),
        Product(name: "Mleko 2% (Łaciate)",
                imageName: "mleko_laciate",
                kcalPer100g: 50, proteinPer100g: 3.4, carbsPer100g: 4.9, fatPer100g: 2),
        Product(name: "Czekolada gorzka (Wedel 80%)",
                imageName: "czekolada_wedel",
                kcalPer100g: 520, proteinPer100g: 7, carbsPer100g: 46, fatPer100g: 35),
        Product(name: "Orzechy włoskie",
                imageName: "orzechy_wloskie",
                kcalPer100g: 654, proteinPer100g: 15, carbsPer100g: 14, fatPer100g: 65),
        Product(name: "Oliwa z oliwek (Monini)",
                imageName: "oliwa_z_oliwek",
                kcalPer100g: 884, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 100),
        Product(name: "Ziemniaki",
                imageName: "ziemniaki",
                kcalPer100g: 80, proteinPer100g: 2, carbsPer100g: 17, fatPer100g: 0.1),
        Product(name: "Makrela (Marinero)",
                imageName: "makrela_marinero",
                kcalPer100g: 195, proteinPer100g: 22, carbsPer100g: 5, fatPer100g: 12),
        Product(name: "Serek wiejski (Piątnica)",
                imageName: "serek_wiejski_piatnica",
                kcalPer100g: 98, proteinPer100g: 11, carbsPer100g: 3, fatPer100g: 4)
    ]

    @Published var eatenMeals: [EatenMeal] = []
    @Published var lastUpdateDate: Date? = nil
    
    func calculateBMI() {
        guard let weight = weight, let height = height else {
            self.bmi = 0.0
            return
        }
        let heightInMeters = Float(height) / 100.0
        self.bmi = Float(weight) / (heightInMeters * heightInMeters)
    }
    
    func dailyResetIfNeeded() {
        let calendar = Calendar.current
        let now = Date()
            
            
        guard let lastDate = lastUpdateDate else {
            lastUpdateDate = now
            return
        }
            
        let dayNow = calendar.dateComponents([.year, .month, .day], from: now)
        let dayLast = calendar.dateComponents([.year, .month, .day], from: lastDate)
            
        if dayNow.year != dayLast.year || dayNow.month != dayLast.month || dayNow.day != dayLast.day {
            kcal_burned = 0
            kcal_consumed = 0
            eatenMeals.removeAll()
        }
        lastUpdateDate = now
    }
    
    func dailyGoalStatus() -> String {
        let net = kcal_consumed - kcal_burned
            
        switch weightGoal {
        case "Loose weight":
            if net < 0 {
                return "Good balance - losing weight"
            } else {
                return "Bad balance - gaining weight"
            }
        case "Maintain weight":
            if abs(net) <= 200 {
                return "Good balance - maintaining weight"
            } else if net < 0 {
                return "Bad balance - losing weight"
            } else {
                return "Bad balance - gaining weight"
            }
        case "Gain weight":
            if net > 0 {
                return "Good balance - gaining weight"
            } else {
                return "Bad balance - losing weight"
            }
        default:
            return "-- no goal set --"
        }
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
        case allProducts, eatenMeals
        
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
        
        allProducts = try container.decodeIfPresent([Product].self, forKey: .allProducts) ?? []
        eatenMeals = try container.decodeIfPresent([EatenMeal].self, forKey: .eatenMeals) ?? []
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
        
        try container.encode(allProducts, forKey: .allProducts)
        try container.encode(eatenMeals, forKey: .eatenMeals)
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
