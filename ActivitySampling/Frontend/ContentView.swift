//
//  ContentView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 12.12.21.
//

import Foundation
import SwiftUI

class ContentViewModel : ObservableObject {
    let requestHandler: RequestHandler
    
    @Published var formDisabled = true
    @Published var activity = ""
    
    @Published var activities: [Activity] = []
    
    private var period: TimeInterval = 0
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
        
        let center = NotificationCenter.default
        center.addObserver(forName: .periodElapsed, object: nil, queue: nil) { notification in
            self.formDisabled = false
            self.period = notification.userInfo!["period"] as! TimeInterval
        }
    }
    
    func run() {
        activities = requestHandler.selectAllActivities()
    }
    
    func logActivity() {
        requestHandler.logActivity(activity, period: period)
        activities = requestHandler.selectAllActivities()
        formDisabled = true
    }
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self, name: .periodElapsed, object: nil)
    }
}

struct ContentView: View {
    @ObservedObject var model: ContentViewModel
    @ObservedObject var notifier: Notifier
    
    var body: some View {
        VStack(alignment: .leading) {
            ActivityFormView(disabled: $model.formDisabled, activity: $model.activity, onLog: {
                model.logActivity()
                
            })
            PeriodView(period: $notifier.period, remaining: $notifier.remainingTime)
            ActivityLogView(activities: $model.activities, onSelect: { activity in
                model.activity = activity.description
            })
        }
        .padding()
        .frame(width: 320, height: 640)
        .onAppear(perform: {
            model.run()
        })
        .onDisappear {
            exit(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(model: ContentViewModel(requestHandler: .preview), notifier: .preview)
        }
    }
}
