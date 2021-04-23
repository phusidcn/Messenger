//
//  SceneCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/22/21.
//

import Foundation
import UIKit

class ScenceCoordinator: BaseCoordinator {
    let window: UIWindow
    let windowScene: UIWindowScene
    var isLoggedIn: Bool = false
    
    init(withWindow window: UIWindow, windowScene: UIWindowScene) {
        self.window = window
        self.windowScene = windowScene
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
