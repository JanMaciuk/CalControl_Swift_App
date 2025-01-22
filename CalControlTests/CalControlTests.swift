import XCTest

class HealthTrackerTests: XCTestCase {
    
    var healthTracker: HealthTracker!  // Assuming the class is named HealthTracker
    
    override func setUp() {
        super.setUp()
        healthTracker = HealthTracker()
    }
    
    override func tearDown() {
        healthTracker = nil
        super.tearDown()
    }

    // Test BMI calculation
    func testCalculateBMI() {
        // Test when weight and height are provided
        healthTracker.weight = 70
        healthTracker.height = 175
        
        healthTracker.calculateBMI()
        XCTAssertEqual(healthTracker.bmi, 22.86, accuracy: 0.01, "BMI should be calculated correctly")
        
        // Test when weight or height is missing
        healthTracker.weight = nil
        healthTracker.height = 175
        healthTracker.calculateBMI()
        XCTAssertEqual(healthTracker.bmi, 0.0, "BMI should be 0 when weight is missing")
        
        healthTracker.weight = 70
        healthTracker.height = nil
        healthTracker.calculateBMI()
        XCTAssertEqual(healthTracker.bmi, 0.0, "BMI should be 0 when height is missing")
    }
    
    // Test daily reset functionality
    func testDailyResetIfNeeded() {
        // Test the reset function when no lastUpdateDate exists
        healthTracker.lastUpdateDate = nil
        healthTracker.dailyResetIfNeeded()
        XCTAssertNotNil(healthTracker.lastUpdateDate, "lastUpdateDate should be set after reset")
        
        // Test the reset function when lastUpdateDate is the same day
        let now = Date()
        healthTracker.lastUpdateDate = now
        healthTracker.kcal_burned = 500
        healthTracker.kcal_consumed = 700
        healthTracker.eatenMeals = ["Breakfast", "Lunch"]
        
        healthTracker.dailyResetIfNeeded()
        XCTAssertEqual(healthTracker.kcal_burned, 500, "kcal_burned should not reset if it's the same day")
        XCTAssertEqual(healthTracker.kcal_consumed, 700, "kcal_consumed should not reset if it's the same day")
        XCTAssertEqual(healthTracker.eatenMeals.count, 2, "eatenMeals should not reset if it's the same day")
        
        // Test the reset function when lastUpdateDate is a different day
        let calendar = Calendar.current
        healthTracker.lastUpdateDate = calendar.date(byAdding: .day, value: -1, to: now)
        healthTracker.dailyResetIfNeeded()
        XCTAssertEqual(healthTracker.kcal_burned, 0, "kcal_burned should reset on a new day")
        XCTAssertEqual(healthTracker.kcal_consumed, 0, "kcal_consumed should reset on a new day")
        XCTAssertEqual(healthTracker.eatenMeals.count, 0, "eatenMeals should reset on a new day")
    }
    
    // Test daily goal status calculation
    func testDailyGoalStatus() {
        healthTracker.kcal_burned = 500
        healthTracker.kcal_consumed = 1000
        
        // Test Loose weight goal
        healthTracker.weightGoal = "Loose weight"
        XCTAssertEqual(healthTracker.dailyGoalStatus(), "Bad balance - gaining weight", "Status should reflect gaining weight")
        
        // Test Maintain weight goal
        healthTracker.weightGoal = "Maintain weight"
        XCTAssertEqual(healthTracker.dailyGoalStatus(), "Bad balance - gaining weight", "Status should reflect gaining weight")
        
        // Test Gain weight goal
        healthTracker.weightGoal = "Gain weight"
        XCTAssertEqual(healthTracker.dailyGoalStatus(), "Bad balance - losing weight", "Status should reflect losing weight")
        
        // Test no goal set
        healthTracker.weightGoal = ""
        XCTAssertEqual(healthTracker.dailyGoalStatus(), "-- no goal set --", "Status should reflect no goal set")
    }
    
    // Test kcal reset function
    func testResetKcalories() {
        let calendar = Calendar.current
        let now = Date()
        
        // Test when kcal_change_date is the same day
        healthTracker.kcal_change_date = now
        healthTracker.kcal_burned = 500
        healthTracker.resetKcalories()
        XCTAssertEqual(healthTracker.kcal_burned, 500, "kcal_burned should not reset if it's the same day")
        
        // Test when kcal_change_date is a different day
        let yesterday = calendar.date(byAdding: .day, value: -1, to: now)!
        healthTracker.kcal_change_date = yesterday
        healthTracker.kcal_burned = 500
        healthTracker.resetKcalories()
        XCTAssertEqual(healthTracker.kcal_burned, 0, "kcal_burned should reset if kcal_change_date is a different day")
    }

    // Test createDateWithTime method
    func testCreateDateWithTime() {
        let calendar = Calendar.current
        let hour = 8
        let minute = 30
        let result = healthTracker.createDateWithTime(hour: hour, minute: minute)
        
        let components = calendar.dateComponents([.hour, .minute], from: result)
        XCTAssertEqual(components.hour, hour, "Hour should be set correctly")
        XCTAssertEqual(components.minute, minute, "Minute should be set correctly")
    }
}
