//
//  AppCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/21/21.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    var isLoggedIn: Bool = false
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        if isLoggedIn {
            
        } else {
            let onboardCoordinator = OnboardCoordinator(navigationController: navigationController)
            onboardCoordinator.start()
        }
    }
}
