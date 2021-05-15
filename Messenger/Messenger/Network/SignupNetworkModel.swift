//
//  SignupNetworkModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/15/21.
//

import Foundation

class SignupNetworkModel: Codable {
    let success: Bool
    let error: String
    let data: [String]
    
    init(success: Bool, error: String, data: [String]) {
        self.success = success
        self.error = error
        self.data = data
    }
}
