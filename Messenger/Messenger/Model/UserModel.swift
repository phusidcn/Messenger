//
//  UserModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import ChatViewController

struct UserModel: Userable, Decodable {

    let id: String
    let name: String
    let avatarURL: URL?
    let phoneNumber: String
    let password: String

    var idNumber: String {
        get {
            return id.description
        }
    }

    var displayName: String {
        get {
            return name
        }
    }

    init(id: String? = nil, name: String, password: String, phoneNumber: String, avatarURL: URL? = nil) {
        self.id = id ?? ""
        self.name = name
        self.phoneNumber = phoneNumber
        self.password = password
        self.avatarURL = avatarURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case phoneNumber
        case password
        case avatarURL = "avatar_url"
    }
}
