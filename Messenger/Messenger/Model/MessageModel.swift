//
//  MessageModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation

import Foundation

enum MessageType: Int, Decodable {
    case text = 0
    case file
}

struct MessageModel: Decodable {

    let id: String!
    let type: MessageType
    var text: String?
    var file: FileInfo?
    let sendByID: String!
    let receivedID: String!
    let createdAt: Date!
    let updatedAt: Date?
    var isOutgoing: Bool = true

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case text
        case file
        case sendByID = "sender_id"
        case receivedID = "received_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: String, type: MessageType, sendByID: String, receivedID: String, createdAt: Date) {
        self.id = id
        self.type = type
        self.sendByID = sendByID
        self.receivedID = receivedID
        self.createdAt = createdAt
        self.updatedAt = createdAt
    }

    /// Initialize outgoing text message
    init(id: String, sendByID: String, receivedID: String, createdAt: Date, text: String) {
        self.init(id: id, type: .text, sendByID: sendByID, receivedID: receivedID, createdAt: createdAt)
        self.text = text
    }

    /// Initialize outgoing file message
    init(id: String, sendByID: String, receivedID: String, createdAt: Date, file: FileInfo) {
        self.init(id: id, type: .file, sendByID: sendByID, receivedID: receivedID, createdAt: createdAt)
        self.file = file
    }

    func cellIdentifer() -> String {
        switch type {
        case .text:
            return MessageTextCell.reuseIdentifier
        case .file:
            return MessageImageCell.reuseIdentifier
        }
    }
}

