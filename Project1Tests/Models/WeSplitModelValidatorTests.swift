//
//  WeSplitModelValidator.swift
//  Project1Tests
//
//  Created by vn00082 on 10/14/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import XCTest
@testable import Project1

class WeSplitModelValidatorTests: XCTestCase {
    var sut:WeSplitModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = WeSplitModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    //MARK: Unit Test Case for Amount
    func testWeSplitModelValidator_WhenValidAmountProvided_ShouldReturnTrue() {
        
       let isAmountValid1 = sut.isAmountValid(amount:10)
        XCTAssertTrue((isAmountValid1), "The isAmountValid() should have returned TRUE for the valid amount but returned FALSE")
    }
    func testWeSplitModelValidator_WhenZeroGivenAsAmount_ShouldReturnFalse(){
        
        let isAmountValid = sut.isAmountValid(amount:0)
        XCTAssertFalse((isAmountValid), "The isAmountValid() should return false for the Zero as input but returned true")
        
    }
    //MARK: Unit Test case for Number of People
    func testWeSplitModeValidator_WhenValidNoOfPlp_ShouldReturnTrue(){
        let isValidNum = sut.isNumValid(numbOfPeople:5)
        XCTAssertTrue(isValidNum,"The isValidNum() should return TRUE for the valid number of people else return False for invalid number of people")
    }
    func testWeSplitModeValidator_WhenInvalidNoOfPlp_ShouldReturnFalse(){
        let isValidNum = sut.isNumValid(numbOfPeople: 100)
        XCTAssertFalse(isValidNum,"The isValidNum() should return TRUE for the valid number of people else return False for invalid number of people")
    }
    //MARK: Unit Test Case for Tip Percentage
    func testWeSplitModeValidator_WhenValidTip_ShouldReturnInt(){
        let tipArr = [10, 15, 20, 25, 0]
        let isValidTipA = sut.isValidTip(value:25, in:tipArr)
        XCTAssertNotNil(isValidTipA, "Tip amount is not null, user has entered Value from given tipArr")
        XCTAssertEqual(isValidTipA,25)
    
    }
    
    //MARK: Unit Test Case for calculating Final Amount
    func testWeSplitModeValidator_calculateFinalAmount_ShouldReturnInt(){
        let finalAmount = sut.CalculateFinalAmount(Amount:20, NbrofP: 4, tipAdd: 25)
        XCTAssertEqual(finalAmount,6.25,"Final Perperson amount is as expected")
        
    }
}
