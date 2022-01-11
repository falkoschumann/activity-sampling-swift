//
//  ContentView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 12.12.21.
//

import Foundation
import SwiftUI

struct ContentViewData {
    var formDisabled = false
    var activity = ""
    var period = 20 * 60.0
    var remainingTime = 20 * 60.0
}

struct ContentView: View {
    @State private var data = ContentViewData()
    @State private var activities: [Activity] = []
    
    let requestHandler: RequestHandler
    
    var body: some View {
        VStack(alignment: .leading) {
            ActivityFormView(disabled: $data.formDisabled, activity: $data.activity, log: { logActivity() })
            PeriodView(period: $data.period, remaining: $data.remainingTime)
            ActivityLogView(activities: $activities)
        }
        .padding()
        .frame(width: 320, height: 640)
        .onAppear(perform: {
            run()
        })
        .onDisappear {
            exit(0)
        }
    }
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func run() {
        activities = requestHandler.selectAllActivities()
    }
    
    private func logActivity() {
        requestHandler.logActivity(data.activity)
        activities = requestHandler.selectAllActivities()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(requestHandler: .preview)
        }
    }
}
