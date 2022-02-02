//
//  CSVEventStore.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 30.01.22.
//

import Foundation
import TabularData

class CSVEventStore: EventStore {
    func record(_ event: Event) {
        do {
            if let e = event as? ActivityLoggedEvent {
                var dataFrame = try openFile()
                dataFrame.append(row: e.timestamp, e.period, e.activity)
                try saveFile(dataFrame)
                NotificationCenter.default.post(name: .eventRecorded, object: event)
            }
        } catch {
            print("Error while writing CSV file: \(error)")
        }
    }
    
    func replay() -> [Event] {
        do {
            let dataFrame = try openFile()
            var events = [Event]()
            for row in dataFrame.rows {
                events.append(ActivityLoggedEvent(
                    timestamp: row["timestamp"] as! Date,
                    period: row["period"] as! Double,
                    activity: row["activity"] as! String
                ))
            }
            return events
        } catch {
            print("Error while reading CSV file: \(error)")
            return [Event]()
        }
    }
    
    private func openFile() throws -> DataFrame {
        let url = try getUrl()
        if FileManager.default.fileExists(atPath: url.path) {
            let dataFrame = try DataFrame(
                contentsOfCSVFile: url,
                columns: ["timestamp", "period", "activity"],
                types: ["timestamp": .date, "period": .double, "activity": .string]
            )
            print(dataFrame)
            return dataFrame
        } else {
            print("File does not exists: \(url.absoluteString)")
            return DataFrame()
        }
        
    }
    
    private func saveFile(_ dataFrame: DataFrame) throws {
        let url = try getUrl()
        try dataFrame.writeCSV(to: url)
    }
    
    private func getUrl() throws -> URL {
        let baseUrl = try FileManager.default.url(
            for: .documentDirectory,
               in: .userDomainMask,
               appropriateFor: nil,
               create: false
        )
        let url = baseUrl.appendingPathComponent("activity-log.csv")
        print("Activity log saved to \(url)")
        return url
    }
}
