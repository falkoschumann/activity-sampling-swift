//
//  Notifier.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 19.01.22.
//

import Foundation

class Notifier : ObservableObject {
    static let shared = Notifier()
    
    static let preview: Notifier = {
        let notifier = Notifier()
        notifier.period = 20 * 60
        notifier.remainingTime = 8 * 60 + 15
        return notifier
    }()
    
    @Published var period = 0.0
    @Published var remainingTime = 0.0
    
    private var timer: Timer?
    
    deinit {
        stop()
    }
    
    func start(withPeriod: TimeInterval) {
        period = withPeriod
        remainingTime = withPeriod
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.remainingTime = self.period
                NotificationCenter.default.post(name: .ActivitySamplingOnPeriodElapsed, object: self)
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}

extension Notification.Name {
    static let ActivitySamplingOnPeriodElapsed = Notification.Name("on-period-elapsed")
}
