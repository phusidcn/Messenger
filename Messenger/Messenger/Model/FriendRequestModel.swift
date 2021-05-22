//
//  FriendRequestModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/21/21.
//

import Foundation
import SwiftyJSON

class FriendRequestModel: Decodable {
    let userName: String
    let userId: String
    let greetingString: String
    let timestamp: String
    
    init(userid: String, userName: String, greeting: String, timestamp: String) {
        self.userName = userName
        self.userId = userid
        self.greetingString = greeting
        self.timestamp = timestamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case userName
        case userId
        case greetingString
        case timestamp
    }
}
