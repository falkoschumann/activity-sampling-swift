//
//  ContentView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 12.12.21.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var formDisabled = true
    @State private var activity = ""
    @State private var remainingTime = "00:20:00"
    @State private var progress = 0.0
    @State private var log = "Lorem ipsum"

    private let remainingTimeFormatter: DateFormatter

    var body: some View {
        VStack(alignment: .leading) {
            Text("Activity:")
            TextField("What are you working on?", text: $activity)
                .disabled(formDisabled)
                .onSubmit { logActivity() }
            Button(action: { logActivity() }) {
                Text("Log").frame(maxWidth: .infinity)
            }
                .disabled(formDisabled)
            Text(remainingTime)
                .frame(maxWidth: .infinity)
            ProgressView(value: progress)
            Text(log)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .textSelection(.enabled)
        }
            .padding()
            .frame(width: 320, height: 640)
    }

    init() {
        remainingTimeFormatter = DateFormatter()
        remainingTimeFormatter.dateStyle = .none
        remainingTimeFormatter.timeStyle = .medium
        remainingTimeFormatter.timeZone = TimeZone(abbreviation: "UTC")
        remainingTime = remainingTimeFormatter.string(from: Date(timeIntervalSince1970: 20 * 60))
    }

    private func logActivity() {
        print("logActivity: " + activity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
