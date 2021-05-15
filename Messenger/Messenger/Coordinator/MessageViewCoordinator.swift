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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MessageViewController()
        viewController.coordinator = self
        viewController.viewModel = MessageViewModel(bubbleStyle: .facebook)
        navigationController.pushViewController(viewController, animated: true)
    }
}
