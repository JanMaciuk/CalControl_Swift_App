//
//  CalControlTests.swift
//  CalControlTests
//
//  Created by MacbookGanko on 24/10/2024.
//

import XCTest
@testable import CalControl

class CalControlTests: XCTestCase {

    var appstate: AppState!
        
        override func setUp() {
            super.setUp()
            appstate = AppState()
        }

        override func tearDown() {
            appstate = nil
            super.tearDown()
        }
                
        func testCalculateBMICorrectlyCalculatesBMI() {
            appstate.weight = 70
            appstate.height = 175
            
            appstate.calculateBMI()
            
            let expectedBMI: Float = 22.86
            XCTAssertEqual(appstate.bmi, expectedBMI, accuracy: 0.01)
        }
        
        func testCalculateBMIWithNilWeight() {
            appstate.weight = nil
            appstate.height = 175
            
            appstate.calculateBMI()
            
            XCTAssertEqual(appstate.bmi, 0.0)
        }
        
        func testCalculateBMIWithNilHeight() {
            appstate.weight = 70
            appstate.height = nil
            
            appstate.calculateBMI()
            
            XCTAssertEqual(appstate.bmi, 0.0)
        }

            
        func testDailyGoalStatusLooseWeight() {
            appstate.kcal_consumed = 2000
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Loose weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Good balance - losing weight")
        }
        
        func testDailyGoalStatusLooseWeightGaining() {
            appstate.kcal_consumed = 3000
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Loose weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Bad balance - gaining weight")
        }
        
        func testDailyGoalStatusMaintainWeight() {
            appstate.kcal_consumed = 2500
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Maintain weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Good balance - maintaining weight")
        }
        
        func testDailyGoalStatusMaintainWeightLosing() {
            appstate.kcal_consumed = 2000
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Maintain weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Bad balance - losing weight")
        }
        
        func testDailyGoalStatusGainWeight() {
            appstate.kcal_consumed = 3000
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Gain weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Good balance - gaining weight")
        }
        
        func testDailyGoalStatusGainWeightLosing() {
            appstate.kcal_consumed = 2000
            appstate.kcal_burned = 2500
            appstate.weightGoal = "Gain weight"
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "Bad balance - losing weight")
        }
        
        func testDailyGoalStatusNoGoal() {
            appstate.weightGoal = ""
            
            let result = appstate.dailyGoalStatus()
            
            XCTAssertEqual(result, "-- no goal set --")
        }
}
