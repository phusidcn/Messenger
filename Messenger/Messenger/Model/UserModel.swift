//
//  UserModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation

class UserModel {
    let alias: String
    let name: String
    let phone: String
    let id: UUID
    
    init(alias: String, name: String, phone: String, id: UUID) {
        self.alias = alias
        self.name = name
        self.phone = phone
        self.id = id
    }
}
