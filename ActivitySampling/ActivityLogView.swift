//
//  ActivityLogView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 10.01.22.
//

import SwiftUI

struct ActivityLogView: View {
    @Binding var activities: [Activity]
    
    private var log: [WorkingDay] {
        Dictionary(grouping: activities, by: {it in logDateFormatter.string(from: it.timestamp)})
            .map({ (dateString, activities) in
                return WorkingDay(date: logDateFormatter.date(from: dateString)!, activities: activities)
            }).sorted()
    }
    
    var body: some View {
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
        .textSelection(.enabled)
    }
}

private struct WorkingDay : Comparable {
    static func < (lhs: WorkingDay, rhs: WorkingDay) -> Bool {
        return lhs.date < rhs.date
    }
    
    let date: Date
    let activities: [Activity]
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

private let dateFormatter = ISO8601DateFormatter()

struct ActivityLogView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLogView(activities: .constant([
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:20:00Z")!, description: "Lorem ipsum dolor sit amet"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:40:00Z")!, description: "At vero eos et accusam"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-05T08:00:00Z")!, description: "Stet clita kasd gubergren")
        ]))
            .frame(width: 300)
    }
}
