//
//  Data.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 30.01.22.
//

import Foundation

struct Activity: Equatable {
    let timestamp: Date
    let period: TimeInterval
    let description: String
}
