//
//  Events.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 30.01.22.
//

import Foundation

struct ActivityLoggedEvent: Event {
    let timestamp: Date
    let period: TimeInterval
    let activity: String
}
