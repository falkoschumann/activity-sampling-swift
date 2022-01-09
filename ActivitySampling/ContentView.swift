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

struct WorkingDay {
    let date: Date
    let activities: [Activity]
}

struct ContentView: View {
    @State private var data = ContentViewData()
    @State private var log: [WorkingDay] = []
    
    let requestHandler: RequestHandler
    
    var body: some View {
        VStack(alignment: .leading) {
            ActivityFormView(disabled: $data.formDisabled, activity: $data.activity, log: { logActivity() })
            PeriodView(period: $data.period, remaining: $data.remainingTime)
            List() {
                ForEach(log, id: \.date) { workingDay in
                    Section(header: Text(workingDay.date, formatter: logDateFormatter)) {
                        ForEach(workingDay.activities, id: \.timestamp) { activity in
                            HStack {
                                Text(activity.timestamp, formatter: logTimeFormatter)
                                Text("-")
                                Text(activity.description)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .textSelection(.enabled)
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
        let activities = requestHandler.selectAllActivities()
        display(activities: activities)
    }
    
    private func logActivity() {
        requestHandler.logActivity(data.activity)
        
        let activities = requestHandler.selectAllActivities()
        display(activities: activities)
    }
    
    func display(activities: [Activity]) {
        log = Dictionary(grouping: activities, by: {it in logDateFormatter.string(from: it.timestamp)})
            .map({ (dateString, activities) in
                return WorkingDay(date: logDateFormatter.date(from: dateString)!, activities: activities)
            })
    }
}

private let logDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

private let logTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(requestHandler: .preview)
        }
    }
}
