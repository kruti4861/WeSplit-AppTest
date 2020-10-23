//
//  WeSplitAppUITests.swift
//  WeSplitAppUITests
//
//  Created by vn00082 on 10/22/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import XCTest

class WeSplitAppUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUpWithError() throws {
        
        continueAfterFailure = false

        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testWeSplitApp_whenElementsareEnabled() throws {
        
        let tablesQuery = XCUIApplication().tables
        let amount = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Amount"]/*[[".cells[\"Amount\"].textFields[\"Amount\"]",".textFields[\"Amount\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let nbrPlp=tablesQuery/*@START_MENU_TOKEN@*/.buttons["Number of people"]/*[[".cells[\"Number of people\"].buttons[\"Number of people\"]",".buttons[\"Number of people\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let selectNbrPlp = XCUIApplication().tables.buttons["4 people"]
        let tipVal =  tablesQuery/*@START_MENU_TOKEN@*/.buttons["20%"]/*[[".cells[\"10%, 10%, 15%, 15%, 20%, 20%, 25%, 25%, 0%, 0%\"]",".segmentedControls.buttons[\"20%\"]",".buttons[\"20%\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let indAmt = tablesQuery.cells["$0.00"].otherElements.containing(.staticText, identifier:"$0.00").element
                        
        XCTAssertTrue(amount.isEnabled,"Amount Field is not Enable for user interaction")
        XCTAssertTrue(nbrPlp.isEnabled,"Number of People field is not Enable for user Interaction")
        XCTAssertTrue(tipVal.isEnabled,"User is unable to select tip amount")
        XCTAssertTrue(indAmt.isEnabled,"Tip amount is not set to $0.00")

    }
    func testWeSplitApp_ProvideValidInputs() throws{
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells["Amount"].otherElements.containing(.textField, identifier:"Amount").element.tap()
        
        let amountTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Amount"]/*[[".cells[\"Amount\"].textFields[\"Amount\"]",".textFields[\"Amount\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        amountTextField.tap()
        amountTextField.typeText("200")
        amountTextField.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Number of people"]/*[[".cells[\"Number of people\"].buttons[\"Number of people\"]",".buttons[\"Number of people\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables.buttons["5 people"].tap()
        XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["25%"]/*[[".cells[\"10%, 10%, 15%, 15%, 20%, 20%, 25%, 25%, 0%, 0%\"]",".segmentedControls.buttons[\"25%\"]",".buttons[\"25%\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        //tablesQuery.staticTexts["$50.00"].tap()
        let indValue = tablesQuery.staticTexts["$50.00"].value
        
        XCTAssertNotNil(indValue, "Individual Amount is not calculated")
                
    }
    
    func testWeSplitApp_ProvideInvalidInputs() throws{
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells["Amount"].otherElements.containing(.textField, identifier:"Amount").element.tap()
        
        let amountTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Amount"]/*[[".cells[\"Amount\"].textFields[\"Amount\"]",".textFields[\"Amount\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        amountTextField.tap()
        amountTextField.typeText("abcdefghi")
        amountTextField.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Number of people"]/*[[".cells[\"Number of people\"].buttons[\"Number of people\"]",".buttons[\"Number of people\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables.buttons["2 people"].tap()
        XCUIApplication().tables
        tablesQuery.buttons["0%"].tap()
        let indValue = tablesQuery.staticTexts["$0.00"].value
        XCTAssertFalse((indValue == nil), "Valid data is entered")
        XCTAssertNotNil(indValue, "Valid data is entered")
        //XCTAssertEqual($0.00, indValue, accuracy: 0.00, "Valid data is entered")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
