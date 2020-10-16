//
//  WeSplitModelWebServicesTests.swift
//  Project1Tests
//
//  Created by vn00082 on 10/16/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import XCTest
@testable import Project1

class WeSplitModelWebServicesTests: XCTestCase {
    var sut:WeSplitWebService!
    var WeSplitModel:WeSplitAppRequestModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut =  WeSplitWebService(urlString: WeSplitConstant.weSplitURL, urlSession: urlSession)
        WeSplitModel = WeSplitAppRequestModel(amount: 100, nbrofplp: 3, tipVal:20, indAmount:40)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut=nil
        WeSplitModel=nil
        MockURLProtocol.stubResponseData=nil
        MockURLProtocol.error = nil
        
    }
    //Mark: Unit test for Mock Web Servic Request and Response
    func testWeSplitWebService_WhengivenSuccessfulResponse_ReturnSuccess(){
        //Arrange
        
        let jsonString = "{\"status\":\"Ok\", \"responseCode\":\"200\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "WeSplit WebService Expectation")
        //Act
        sut.WeSplit(withFrom : WeSplitModel){(WeSplitResponseModel, error) in
            //Assert
            XCTAssertEqual(WeSplitResponseModel?.status, "Ok")
            XCTAssertEqual(WeSplitResponseModel?.responseCode, 200)
            expectation.fulfill()
        }
        self.wait(for:[expectation], timeout: 60)
        
    }
    func testWeSplitWebService_WhenReceiveDifferentResponse_ErrortookPlace(){
        
        let jsonString = "{\"status\":\"Ok\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "WeSplit WebService Expectation for JSON response different than expected")
        //Act
        sut.WeSplit(withFrom : WeSplitModel){(WeSplitResponseModel, error) in
            //Assert
            XCTAssertNil(WeSplitResponseModel,"Make sure responseModel does not have any response")
            //XCTAssertEqual(error, WeSpliterror.responseModelParsingError)
            
            expectation.fulfill()
        }
        self.wait(for:[expectation], timeout:5)
        
    }
    func testWeSpiltWebService_WhenEmptyURLStringProvided_ReturnsError(){
        let expectation = self.expectation(description: "An Empty request URL string expectation ")
        sut = WeSplitWebService(urlString: "")
        sut.WeSplit(withFrom: WeSplitModel){(WeSplitResponseModel, error) in
            XCTAssertEqual(error, WeSpliterror.invalidRequestURLStringError,"Invalid request URL given")
            XCTAssertNil(WeSplitResponseModel,"The Response is Null")
            expectation.fulfill()
        }
        self.wait(for:[expectation], timeout: 2)
    }
    func testWeSplitWebService_WhenURLRequestFails_ReturnsErrorMessageDescription(){
        let expectation = self.expectation(description: "Failed Request Expectation ")
        let errorDescription = "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection."
        MockURLProtocol.error = WeSpliterror.requestURLFail(description:errorDescription)
        sut.WeSplit(withFrom: WeSplitModel){(WeSplitResponseModel, error) in
            XCTAssertEqual(error, WeSpliterror.requestURLFail(description:errorDescription))
            expectation.fulfill()
        }
        self.wait(for:[expectation], timeout: 2)
        
    }
    
    
}
