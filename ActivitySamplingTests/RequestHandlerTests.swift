//
//  RequestHandlerTests.swift
//  ActivitySamplingTests
//
//  Created by Falko Schumann on 13.12.21.
//

import XCTest

class RequestHandlerTests: XCTestCase {
    private var fixture: RequestHandler!
    
    override func setUpWithError() throws {
        fixture = RequestHandler(dateFactory: { ISO8601DateFormatter().date(from: "2021-12-13T21:39:56Z")! })
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogActivity() throws {
        fixture.logActivity("Lorem ipsum")
        
        let activities = fixture.selectAllActivities()
        
        XCTAssertEqual(activities, [createActivity(timestamp: "2021-12-13T21:39:56Z")])
    }
    
    func testSelectActivities() throws {
        fixture.logActivity("Lorem ipsum")
        
        let activities = fixture.selectAllActivities()
        
        XCTAssertEqual(activities, [createActivity(timestamp: "2021-12-13T21:39:56Z")])
    }
}

fileprivate func createActivity(timestamp: String) -> Activity {
    let t = ISO8601DateFormatter().date(from: timestamp)
    let d = "Lorem ipsum"
    return Activity(timestamp: t!, description: d)
}
