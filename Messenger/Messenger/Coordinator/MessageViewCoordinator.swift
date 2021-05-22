//
//  ChatWindowCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation
import UIKit
import SwiftyJSON

class MessageViewCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    let userModel: UserModel
    
    init(navigationController: UINavigationController, userModel: UserModel) {
        self.navigationController = navigationController
        self.userModel = userModel
    }
    
    func start() {
        let viewController = MessageViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.coordinator = self
        CoreDataHandler.shareCoreDataHandler.offlineMessage.removeAll()
        NetworkHandler.sharedNetworkHandler.sendGetCachedMessage() { data, response, error in
            let json = JSON(data)
            if let success = json["success"].bool, success == true {
                guard let messages = json["data"].array else { return }
                for message in messages {
                    let senderID = message["senderID"].string!
                    let content = message["message"].string!
                    let id = message["ts"].string!
                    guard let code = message["code"].int, code == 202 else { return }
                    let messageModel = MessageModel(id: id, sendByID: senderID, receivedID: CoreContext.shareCoreContext.userId, createdAt: Date(timeIntervalSince1970: TimeInterval(id)!), text: content)
                    CoreDataHandler.shareCoreDataHandler.saveMessage(messageModel: messageModel)
                }
            }
            CoreDataHandler.shareCoreDataHandler.getThreadChatData()
            let messageViewModel = MessageViewModel(bubbleStyle: .facebook)
            messageViewModel.messages = CoreDataHandler.shareCoreDataHandler.getMessage(ofUser: self.userModel)
            messageViewModel.currentUser = CoreContext.shareCoreContext.currentUser
            messageViewModel.users.append(self.userModel)
            viewController.viewModel = messageViewModel
            DispatchQueue.main.async {
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}
