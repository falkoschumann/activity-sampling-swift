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
        fixture = RequestHandler()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogActivity() throws {
        fixture.logActivity(createActivity())
        
        let activities = fixture.selectAllActivities()
        XCTAssertEqual(activities, [createActivity()])
    }
    
    func testSelectActivities() throws {
        fixture.logActivity(createActivity())
        
        let activities = fixture.selectAllActivities()
        
        XCTAssertEqual(activities, [createActivity()])
    }
}

fileprivate func createActivity() -> Activity {
    let timestamp = try! Date("2021-12-13T21:39:56Z", strategy: .iso8601)
    let description = "Lorem ipsum"
    return Activity(timestamp: timestamp, description: description)
}
