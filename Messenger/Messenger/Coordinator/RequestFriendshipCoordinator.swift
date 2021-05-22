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
    var userInfo: UserModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RequestFriendshipViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.userModel = userInfo
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
