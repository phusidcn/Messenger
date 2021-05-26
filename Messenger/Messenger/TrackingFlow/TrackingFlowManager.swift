//
//  TrackingFlowManager.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/23/21.
//

import Foundation
import UIKit

class TrackingFlowManager: NSObject {
    static let sharedTrackingFlowManager = TrackingFlowManager()
    var threshold: Int = 2
    var currentCachingLog = [TrackingModel]()
    var waittingResponseLog = [TrackingModel]()
    
    func addTrackingLog(_ log: TrackingModel) {
        if log.labelControl == "Logout Button" {
            var trackString = "["
            for i in 0 ..< currentCachingLog.count {
                let log = currentCachingLog[i]
                let logString  = log.convertToJSON()
                trackString.append(logString)
                trackString.append(",")
            }
            trackString.append(log.convertToJSON())
            trackString.append("]")
            NetworkHandler.sharedNetworkHandler.sendTrackingInfo(trackString) {data, response, error in
                self.waittingResponseLog.removeAll()
                self.currentCachingLog.removeAll()
            }
            return
        }
        currentCachingLog.append(log)
        if currentCachingLog.count > threshold - 1 {
            var trackString = "["
            for i in 0 ..< currentCachingLog.count - 1 {
                let log = currentCachingLog[i]
                let logString  = log.convertToJSON()
                trackString.append(logString)
                trackString.append(",")
            }
            trackString.append(currentCachingLog[currentCachingLog.count - 1].convertToJSON())
            trackString.append("]")
            self.waittingResponseLog = self.currentCachingLog
            self.currentCachingLog.removeAll()
            NetworkHandler.sharedNetworkHandler.sendTrackingInfo(trackString) {data, response, error in
                self.waittingResponseLog.removeAll()
            }
        }
    }
}
