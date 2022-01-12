//
//  PeriodView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 06.01.22.
//

import SwiftUI

struct PeriodView: View {
    @Binding var period: TimeInterval
    @Binding var remaining: TimeInterval
    
    private var remainingTime: String {
        remainingTimeFormatter.string(from: Date(timeIntervalSince1970: remaining))
    }
    
    var body: some View {
        VStack {
            Text(remainingTime)
            ProgressView(value: 1 - remaining / period)
        }
    }
}

private let remainingTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .medium
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}()

struct PeriodView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeriodView(period: .constant(1200), remaining: .constant(1200))
                .previewDisplayName("not started")
                .frame(width: 300)
            PeriodView(period: .constant(1200), remaining: .constant(400))
                .previewDisplayName("in progress")
                .frame(width: 300)
            PeriodView(period: .constant(1200), remaining: .constant(0))
                .previewDisplayName("finished")
                .frame(width: 300)
            
        }
    }
}
