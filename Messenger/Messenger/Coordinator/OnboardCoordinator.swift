//
//  OnboardCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/21/21.
//

import Foundation
import UIKit

class OnboardCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = OnboardViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func continueToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
}
