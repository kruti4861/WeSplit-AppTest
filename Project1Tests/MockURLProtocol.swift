//
//  MockURLProtocol.swift
//  Project1Tests
//
//  Created by vn00082 on 10/16/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import Foundation
class MockURLProtocol: URLProtocol{
    static var stubResponseData: Data?
    static var error: Error?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        if let WeSplitError = MockURLProtocol.error{
            self.client?.urlProtocol(self, didFailWithError: WeSplitError)
        }else{
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading(){
        
    }
    
}
