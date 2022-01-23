//
//  ActivitySamplingCommands.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 19.01.22.
//

import Foundation
import SwiftUI

struct ActivitySamplingCommands: Commands {
    var body: some Commands {
        CommandMenu("Notifications") {
            Menu("Start") {
                Button("10 min") { Notifier.shared.start(withPeriod: 10 * 60) }
                Button("15 min") { Notifier.shared.start(withPeriod: 15 * 60) }
                Button("20 min") { Notifier.shared.start(withPeriod: 20 * 60) }
                Button("30 min") { Notifier.shared.start(withPeriod: 30 * 60) }
                Button("60 min") { Notifier.shared.start(withPeriod: 60 * 60) }
                Button("10 sec") { Notifier.shared.start(withPeriod: 10) }
            }
            Button("Stop") { Notifier.shared.stop() }
        }
    }
}
