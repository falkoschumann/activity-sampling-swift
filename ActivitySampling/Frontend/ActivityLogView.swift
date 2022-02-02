//
//  ActivityLogView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 10.01.22.
//

import SwiftUI

struct ActivityLogView: View {
    @Binding var activities: [Activity]
    
    let onSelect: (_ activity: Activity) -> Void
    
    private var log: [WorkingDay] {
        Dictionary(grouping: activities, by: {it in logDateFormatter.string(from: it.timestamp)})
            .map({ (dateString, activities) in
                WorkingDay(date: logDateFormatter.date(from: dateString)!, activities: activities)
            }).sorted()
    }
    
    var body: some View {
        List() {
            ForEach(log, id: \.date) { workingDay in
                Section(header: Text(workingDay.date, formatter: logDateFormatter)) {
                    ForEach(workingDay.activities, id: \.timestamp) { activity in
                        Button(action: { onSelect(activity) }) {
                            HStack {
                                Text(activity.timestamp, formatter: logTimeFormatter)
                                Text("-")
                                Text(activity.description)
                            }
                        }.buttonStyle(.plain)
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

struct ActivityLogView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLogView(activities: .constant([
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:20:00Z")!, period: 20 * 60, description: "Lorem ipsum dolor sit amet"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:40:00Z")!, period: 20 * 60, description: "At vero eos et accusam"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-05T08:00:00Z")!, period: 20 * 60, description: "Stet clita kasd gubergren")
        ]), onSelect: { _ in })
            .frame(width: 300)
    }
}

private let dateFormatter = ISO8601DateFormatter()
