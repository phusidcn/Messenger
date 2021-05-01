//
//  MessageModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation

class MessageModel {
    let mess_id: UUID
    let sender_id: UUID
    let receiver_id: UUID
    let content: String
    let send_date: Date
    
    init(mess_id: UUID, sender_id: UUID, receiver_id: UUID, content: String, send_date: Date) {
        self.mess_id = mess_id
        self.sender_id = sender_id
        self.receiver_id = receiver_id
        self.content = content
        self.send_date = send_date
    }
}
