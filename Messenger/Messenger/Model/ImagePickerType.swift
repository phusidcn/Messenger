//
//  ImagePickerViewType.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
import ChatViewController

extension ImagePickerType {
    
    var description: String {
        switch self {
        case .slack:
            return "Slack"
        case .actionSheet:
            return "Action Sheet"
        }
    }
}
