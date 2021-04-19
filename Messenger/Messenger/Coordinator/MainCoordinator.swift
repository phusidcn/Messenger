//
//  MainCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/20/21.
//

import Foundation
import UIKit

class MainCoordinator: BaseCoordinator {
    var childCoordinator = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = OnboardViewController.instantiate
        navigationController.pushViewController(viewController, animated: true);
    }
}
