//
//  toolstrackerTests.swift
//  toolstrackerTests
//
//  Created by Monchai Saipin on 10/14/2015.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import XCTest

@testable import toolstracker

class toolstrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func testTrackingModelNotNil(){
        TrackingModel.shareInstance.appendTracking(1, state: "yea", label: "yea", value: "yea")
        XCTAssertNotNil(TrackingModel.shareInstance.trackingList)
    }

    
}
