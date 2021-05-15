//
//  LoginCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/25/21.
//

import Foundation
import UIKit

class LoginCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func coordinateToSignUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        coordinate(to: signUpCoordinator)
    }
    
    func coordinateToThreadChat(withUserId id: String) {
        let chatThreadCoordinator = ChatThreadCoordinator(navigationController: navigationController)
        coordinate(to: chatThreadCoordinator)
    }
}
