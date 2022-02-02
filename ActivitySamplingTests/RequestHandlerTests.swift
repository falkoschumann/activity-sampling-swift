//
//  RequestHandlerTests.swift
//  ActivitySamplingTests
//
//  Created by Falko Schumann on 13.12.21.
//

import XCTest

class RequestHandlerTests: XCTestCase {
    func testLogActivity() throws {
        let fixture = RequestHandler(
            eventStore: MemoryEventStore(),
            dateFactory: { ISO8601DateFormatter().date(from: "2021-12-13T21:39:56Z")! }
        )
        
        fixture.logActivity("Lorem ipsum", period: 20 * 60)
        
        let activities = fixture.selectAllActivities()
        XCTAssertEqual(activities, [
            Activity(
                timestamp: dateFormatter.date(from: "2021-12-13T21:39:56Z")!,
                period: 20 * 60,
                description: "Lorem ipsum"
            )
        ])
    }
    
    func testSelectActivities() throws {
        let fixture = RequestHandler(
            eventStore: MemoryEventStore([
                ActivityLoggedEvent(
                    timestamp: dateFormatter.date(from: "2021-12-13T21:39:56Z")!,
                    period: 20 * 60,
                    activity: "Lorem ipsum"
                )
            ]),
            dateFactory: { ISO8601DateFormatter().date(from: "2021-12-13T21:39:56Z")! }
        )
                
        let activities = fixture.selectAllActivities()
        
        XCTAssertEqual(activities, [
            Activity(
                timestamp: dateFormatter.date(from: "2021-12-13T21:39:56Z")!,
                period: 20 * 60,
                description: "Lorem ipsum"
            )
        ])
    }
}

fileprivate let dateFormatter = ISO8601DateFormatter()
