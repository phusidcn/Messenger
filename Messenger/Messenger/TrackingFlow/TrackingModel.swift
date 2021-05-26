//
//  TrackingModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/23/21.
//

import Foundation
import UIKit
class TrackingModel: NSObject {
    let labelControl: String
    let event: String
    let timestamp: TimeInterval
    let note: String?
    
    init(labelControl: String, event: String, note: String? = nil, timestamp: TimeInterval) {
        self.labelControl = labelControl
        self.event = event
        self.timestamp = timestamp
        self.note = note
    }
    
    func convertToJSON() -> String {
        var json = "{"
        json.append("\"action\":\"\(event)\",")
        json.append("\"object\":\"\(labelControl)\",")
        json.append("\"ts\":\"\(timestamp)\"")
        if let entry = self.note, event == "Search" {
            json.append(",\"note\":\"\(entry)\"}")
            return json
        }
        json.append("}")
        return json
    }
}
