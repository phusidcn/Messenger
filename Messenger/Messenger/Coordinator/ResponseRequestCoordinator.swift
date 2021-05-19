//
//  ResponseRequestCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/18/21.
//

import Foundation
import UIKit

class ResponseRequestCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    let requestedUser: UserModel
    
    init(navigationController: UINavigationController, requestedUser: UserModel) {
        self.navigationController = navigationController
        self.requestedUser = requestedUser
    }
    
    func start() {
        let viewController = ResponseRequestViewController()
        viewController.coordinator = self
        viewController.requestedUser = requestedUser
        navigationController.pushViewController(viewController, animated: true)
    }
}
