//
//  ActivitySamplingApp.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 12.12.21.
//

import SwiftUI

@main
struct ActivitySamplingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: ContentViewModel(requestHandler: .shared), notifier: .shared)
        }.commands() {
            ActivitySamplingCommands()
        }
    }
}
