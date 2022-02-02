//
//  MessageHandler.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 13.12.21.
//

import Foundation

class RequestHandler {
    static let shared = RequestHandler(eventStore: CSVEventStore())
    
    static let preview: RequestHandler = RequestHandler(eventStore: MemoryEventStore([
        ActivityLoggedEvent(timestamp: dateFormatter.date(from: "2022-01-04T21:20:00Z")!, period: 20 * 60, activity: "Lorem ipsum dolor sit amet"),
        ActivityLoggedEvent(timestamp: dateFormatter.date(from: "2022-01-04T21:40:00Z")!, period: 20 * 60, activity: "At vero eos et accusam"),
        ActivityLoggedEvent(timestamp: dateFormatter.date(from: "2022-01-05T09:00:00Z")!, period: 20 * 60, activity: "Stet clita kasd gubergren")
    ]))
    
    private let eventStore: EventStore
    private let dateFactory: () -> Date
    
    init(eventStore: EventStore, dateFactory: @escaping () -> Date) {
        self.eventStore = eventStore
        self.dateFactory = dateFactory
    }
    
    convenience init(eventStore: EventStore) {
        self.init(eventStore: eventStore, dateFactory: { Date() })
    }
    
    func logActivity(_ description: String, period: TimeInterval) {
        eventStore.record(ActivityLoggedEvent(timestamp: dateFactory(), period: period, activity: description))
    }
    
    func selectAllActivities() -> [Activity] {
        return eventStore.replay()
            .filter{ $0 is ActivityLoggedEvent }
            .map {
                let event = $0 as! ActivityLoggedEvent
                return Activity(timestamp: event.timestamp, period: event.period, description: event.activity)
            }
    }
}

fileprivate let dateFormatter = ISO8601DateFormatter()
