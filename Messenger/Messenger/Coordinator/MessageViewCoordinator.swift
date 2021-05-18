//
//  ChatWindowCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation
import UIKit

class MessageViewCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    let userModel: UserModel
    
    init(navigationController: UINavigationController, userModel: UserModel) {
        self.navigationController = navigationController
        self.userModel = userModel
    }
    
    func start() {
        let viewController = MessageViewController()
        viewController.coordinator = self
        var messageViewModel = MessageViewModel(bubbleStyle: .facebook)
        messageViewModel.currentUser = CoreContext.shareCoreContext.currentUser
        messageViewModel.users.append(userModel)
        viewController.viewModel = messageViewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
