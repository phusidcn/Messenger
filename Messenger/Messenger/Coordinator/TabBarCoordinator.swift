//
//  TabBarCoordinator.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/18/21.
//

import Foundation
import UIKit

class TabBarCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let chatNavigationController = UINavigationController()
        chatNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        let chatCoordinator = ChatThreadCoordinator(navigationController: chatNavigationController)
        
        let friendNavigationController = UINavigationController()
        friendNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        let friendCoordinator = RequestListCoordinator(navigationController: friendNavigationController)
        
        tabBarController.viewControllers = [chatNavigationController, friendNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: chatCoordinator)
        coordinate(to: friendCoordinator)
    }
}
