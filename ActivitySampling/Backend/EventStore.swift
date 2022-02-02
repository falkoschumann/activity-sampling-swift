//
//  EventStore.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 25.01.22.
//

import Foundation

protocol Event {
    var timestamp: Date { get }
}

protocol EventStore {
    func record(_ event: Event)
    func replay() -> [Event]
}

extension Notification.Name {
    /// Posted by `EventStore` when an event was recorded. The recorded event is the `object` of the published notification.
    static let eventRecorded = Notification.Name("event-recorded")
}
