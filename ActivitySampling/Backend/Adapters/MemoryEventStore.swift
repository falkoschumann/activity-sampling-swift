//
//  MemoryEventStore.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 30.01.22.
//

import Foundation

class MemoryEventStore: EventStore {
    private var events: [Event]
    
    init(_ events: [Event]) {
        self.events = events
    }
    
    convenience init() {
        self.init([Event]())
    }
    
    func record(_ event: Event) {
        events.append(event)
        NotificationCenter.default.post(name: .eventRecorded, object: event)
    }
    
    func replay() -> [Event] {
        return events
    }
}
