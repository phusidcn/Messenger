//
//  QuickActionModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation

class QuickActionModel  {
    let id: UUID
    let action_content: String
    let expire_time: Date
    let user_id: UUID
    
    init(id: UUID, action_content: String, expire_time: Date, user_id: UUID) {
        self.id  = id
        self.action_content = action_content
        self.expire_time = expire_time
        self.user_id = user_id
    }
}
