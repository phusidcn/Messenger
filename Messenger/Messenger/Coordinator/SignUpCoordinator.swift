//
//  SignupCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/25/21.
//

import Foundation
import UIKit

class SignUpCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SignUpViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
