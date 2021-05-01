//
//  ChatWindowCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import Foundation
import UIKit

class ChatWindowCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ChatWindowViewController()
        viewController.cooridinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
