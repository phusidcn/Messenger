//
//  RequestFriendshipCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/16/21.
//

import Foundation
import UIKit

class RequestFriendshipCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RequestFriendshipViewController()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
