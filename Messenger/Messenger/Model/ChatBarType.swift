//
//  ChatBarType.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
import ChatViewController

extension ChatBarStyle {
    
    var description: String {
        switch self {
        case .default:
            return "Default"
        case .slack:
            return "Slack"
        default:
            return ""
        }
    }
}
