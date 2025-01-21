//
//  CalControlUITests.swift
//  CalControlUITests
//
//  Created by MacbookGanko on 24/10/2024.
//

import XCTest

class CalControlUITests: XCTestCase {

    func testCheckAllUiFiledsSetupScreen(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.textFields["setupScreenHeight"].waitForExistence(timeout: 1))
        XCTAssert(app.textFields["setupScreenUsername"].waitForExistence(timeout: 1))
        XCTAssert(app.datePickers["setupScreenBirthday"].waitForExistence(timeout: 1))
        XCTAssert(app.buttons["setupScreenContinue"].waitForExistence(timeout: 1))
        XCTAssert(app.textFields["setupScreenWeight"].waitForExistence(timeout: 1))
    }
    
    func testBMITest(){
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.textFields["setupScreenUsername"].waitForExistence(timeout: 5))
        
        
        let gender = app.staticTexts["setupScreen♀"]
        gender.tap()
        
        
        let name = app.textFields["setupScreenUsername"]
        name.tap()
        name.typeText("tmp name")
        
        let height = app.textFields["setupScreenHeight"]
        height.tap()
        height.typeText("170")
        
        let weight = app.textFields["setupScreenWeight"]
        weight.tap()
        weight.typeText("70")
        
        let continueButton = app.buttons["setupScreenContinue"]
        continueButton.tap()
        
        XCTAssert(app.staticTexts["SetupScreen2BMI"].waitForExistence(timeout: 0.5))
        
        let bmi = app.staticTexts["SetupScreen2BMI"].label

        XCTAssertEqual(bmi,"\(String(format: "%.6f",70/(1.7*1.7)))")
    }
    
    func testKcalAddMeals(){
        let app = XCUIApplication()
        app.launchArguments.append("--skip-onboarding")
        app.launchArguments.append("--username=UI_TEST")
        app.launchArguments.append("--weight=75")
        app.launchArguments.append("--height=170")
        app.launch()
        
        let buttonActivities = app.buttons["mainMenuViewManageMeals"]
        XCTAssert(buttonActivities.waitForExistence(timeout:5))
        
        buttonActivities.tap()
        
        let parowkiButton = app.buttons["ManageMealsViewProductParówki (Berlinki)"] //xddd
        parowkiButton.tap()
        
        let parowkiGrams = app.textFields["addMealViewEnterGrams"]
        parowkiGrams.tap()
        parowkiGrams.typeText("200")
        
        // kcal 520
        // protein 22 g
        // carbs 10 g
        // fat 42 g
        //TODO sprawdzenie po wpisaniu gramatury
        //            addMealViewKcal
        //        addMealViewProteins
        //        addMealViewCarbs
        //        addMealViewFat
        let addButton = app.buttons["addMealViewAdd"]
        addButton.tap()
        
        //back to menu
        //sprawdzenie w menu
        //sprawdzenie w today meals
        
        
    }
        
    
    
    
    
    func testKcalAddActivites(){
        let app = XCUIApplication()
        app.launchArguments.append("--skip-onboarding")
        app.launchArguments.append("--username=UI_TEST")
        app.launchArguments.append("--weight=75")
        app.launchArguments.append("--height=170")
        app.launch()
        
        let buttonActivities = app.buttons["mainMenuViewManageActivity"]
        XCTAssert(buttonActivities.waitForExistence(timeout:5))
        
        buttonActivities.tap()
        
        
        let buttonAddActivity = app.buttons["activityScreenAddActivity"]
        XCTAssert(buttonAddActivity.waitForExistence(timeout:0.5))
        
        buttonAddActivity.tap()
        
        let activityPicker = app.pickerWheels["activityScreen2Activities"]
        print(activityPicker.debugDescription)
        let activityPicker1 = app.datePickers["activityScreen2Time"]
        print(activityPicker1.debugDescription)
        let activityPicker2 = app.pickers["activityScreen2Intensivity"]
        print(activityPicker2.debugDescription)
        let activityPicker3 = app.staticTexts["activityScreen2BurnedKcal"]
        print(activityPicker3.debugDescription)

        
//        let datePickers = app.datePickers["activityScreen2Time"]
//        datePickers.tap()
//
//        let timePicker = datePickers.children(matching: .any).matching(identifier: "Time Picker").firstMatch
//
//        XCTAssert(timePicker.exists)
//
//        timePicker.adjust(toPickerWheelValue: "01:30")
//
//        timePicker.tap()
//
//        XCTAssertEqual(timePicker.value as? String, "01:30")

        
        
    }
    
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
