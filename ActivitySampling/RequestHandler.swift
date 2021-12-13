//
//  MessageHandler.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 13.12.21.
//

import Foundation

class RequestHandler {
    static let shared = RequestHandler()
    
    private var log = [Activity]()
    
    func logActivity(_ activity: Activity) {
        log.append(activity)
    }
    
    func selectAllActivities() -> [Activity] {
        return log
    }
}
