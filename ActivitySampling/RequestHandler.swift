//
//  MessageHandler.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 13.12.21.
//

import Foundation

struct Activity: Equatable {
    let timestamp: Date
    let description: String
}

class RequestHandler {
    static let shared = RequestHandler()
    
    static let preview: RequestHandler = {
        let handler = RequestHandler()
        let dateFormatter = ISO8601DateFormatter()
        handler.log = [
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:20:00Z")!, description: "Lorem ipsum dolor sit amet"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-04T21:40:00Z")!, description: "At vero eos et accusam"),
            Activity(timestamp: dateFormatter.date(from: "2022-01-05T09:00:00Z")!, description: "Stet clita kasd gubergren")
        ]
        return handler
    }()
    
    private let dateFactory: () -> Date
    private var log = [Activity]()
    
    init(dateFactory: @escaping () -> Date) {
        self.dateFactory = dateFactory
    }
    
    convenience init() {
        self.init(dateFactory: { Date() })
    }
    
    func logActivity(_ description: String) {
        log.append(Activity(timestamp: dateFactory(), description: description))
    }
    
    func selectAllActivities() -> [Activity] {
        return log
    }
}
