//
//  RequestListCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/18/21.
//

import Foundation
import UIKit

class RequestListCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RequestListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func coordinatorToResponseView(withUser user: FriendRequestModel) {
        let coordinator = ResponseRequestCoordinator(navigationController: navigationController, requestedUser: user)
        coordinator.start()
    }
}
