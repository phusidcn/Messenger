//
//  MainContext.swift
//  Messenger
//
//  Created by HuynhLamPhuSi on 5/9/21.
//

import Foundation

class CoreContext: NSObject {
    public static let shareCoreContext = CoreContext()
    var userWaitingFriendShip: [UserModel] = []
    var incommingMessage: [MessageModel] = []
    var groupIncommingMessage: [MessageModel] = []
    var bannerId: String?
    
    var currentUser: UserModel?
    
    public var userId: String {
        get {
            return currentUser?.id ?? ""
        }
    }
    
    public var password: String {
        get {
            return currentUser?.password ?? ""
        }
    }
    
    public var phoneNumber: String {
        get {
            return currentUser?.phoneNumber ?? ""
        }
    }
    
    public func loginByUser(user: UserModel) {
        self.currentUser = user
    }
    
    
}
