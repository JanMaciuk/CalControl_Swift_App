//
//  CalControlUITests.swift
//  CalControlUITests
//
//  Created by MacbookGanko on 24/10/2024.
//

import XCTest

class CalControlUITests: XCTestCase {

    func testCheckAllUiFiledsSetupScreen(){
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
        
        let maitianWeight = app.staticTexts["MaitianWeight"]
        maitianWeight.tap()
        
        let goToMenu = app.buttons["ButtonContinue"]
        goToMenu.tap()
        
        XCTAssert(app.buttons["Quit"].waitForExistence(timeout: 6))
        
        let quit = app.buttons["Quit"]
        quit.tap()
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

        XCTAssertTrue(app.staticTexts["addMealViewKcal"].label.contains("520"), "Label text does not contain '520'")
        XCTAssertTrue(app.staticTexts["addMealViewProteins"].label.contains("22"), "Label text does not contain '22'")
        XCTAssertTrue(app.staticTexts["addMealViewCarbs"].label.contains("10"), "Label text does not contain '10'")
        XCTAssertTrue(app.staticTexts["addMealViewFat"].label.contains("42"), "Label text does not contain '42'")

        let addButton = app.buttons["addMealViewAdd"]
        addButton.tap()
        
        app.buttons["ManageMealsViewProductBackToMenu"].tap()
    
    
        XCTAssertTrue(app.staticTexts["mainMenuViewKcalConsumed"].label.contains("520"), "Label text does not contain '520'")
        
        app.buttons["mainMenuViewTodayMeals"].tap()
        
        XCTAssertEqual(app.staticTexts["TodayEatenMealsViewProductParówki (Berlinki)"].label,"Parówki (Berlinki)")

        XCTAssertTrue(app.staticTexts["TodayEatenMealsViewGramsParówki (Berlinki)"].label.contains("520"), "Label text does not contain '520'")
        XCTAssertTrue(app.staticTexts["TodayEatenMealsViewGramsParówki (Berlinki)"].label.contains("200"), "Label text does not contain '200'")
        
        app.buttons["TodayEatenMealsViewBackToMenu"].tap()
        
        let buttonTodayMeals = app.buttons["mainMenuViewTodayMeals"]
        buttonTodayMeals.tap()

        let eatenMeals = app.staticTexts["mainMenuViewKcalConsumed"]
        XCTAssert(eatenMeals.waitForExistence(timeout:0.5))
        XCTAssertTrue(app.staticTexts["mainMenuViewKcalConsumed"].label.contains("520"), "Label text does not contain '520'")
        XCTAssertTrue(app.staticTexts["mainMenuViewProteinConsumed"].label.contains("22"), "Label text does not contain '22'")
        XCTAssertTrue(app.staticTexts["mainMenuViewCarbsConsumed"].label.contains("10"), "Label text does not contain '10'")
        XCTAssertTrue(app.staticTexts["mainMenuViewFatConsumed"].label.contains("42"), "Label text does not contain '42'")
    }
        
    
//    func testKcalAddActivites(){
//        let app = XCUIApplication()
//        app.launchArguments.append("--skip-onboarding")
//        app.launchArguments.append("--username=UI_TEST")
//        app.launchArguments.append("--weight=75")
//        app.launchArguments.append("--height=170")
//        app.launch()
//        
//        let buttonActivities = app.buttons["mainMenuViewManageActivity"]
//        XCTAssert(buttonActivities.waitForExistence(timeout:5))
//        
//        buttonActivities.tap()
//        
//        
//        let buttonAddActivity = app.buttons["activityScreenAddActivity"]
//        XCTAssert(buttonAddActivity.waitForExistence(timeout:0.5))
//        
//        buttonAddActivity.tap()
//        
//        let activityPicker = app.pickerWheels["activityScreen2Activities"]
//        print(activityPicker.debugDescription)
//        let activityPicker1 = app.datePickers["activityScreen2Time"]
//        print(activityPicker1.debugDescription)
//        let activityPicker2 = app.pickers["activityScreen2Intensivity"]
//        print(activityPicker2.debugDescription)
//        let activityPicker3 = app.staticTexts["activityScreen2BurnedKcal"]
//        print(activityPicker3.debugDescription)
//
//        let datePickers = app.datePickers["activityScreen2Time"]
//        datePickers.tap()

//        let timePicker = datePickers.children(matching: .any).matching(identifier: "Time Picker").firstMatch
//
//        XCTAssert(timePicker.exists)
//
//        timePicker.adjust(toPickerWheelValue: "01:30")
//
//        timePicker.tap()
//
//        XCTAssertEqual(timePicker.value as? String, "01:30")
//        
//    }

}
