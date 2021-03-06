//
//  ChatThreadCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 27/04/2021.
//

import Foundation
import UIKit

class ChatThreadCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ChatThreadViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func coordinateToChatWindowsWith(userModel: UserModel) {
        let coordinator = MessageViewCoordinator(navigationController: navigationController, userModel: userModel)
        coordinate(to: coordinator)
    }
    
    func coordinateToFriendRequestWithUser(_ user: UserModel) {
        let coordinator = RequestFriendshipCoordinator(navigationController: navigationController)
        coordinator.userInfo = user
        coordinate(to: coordinator)
    }
}
