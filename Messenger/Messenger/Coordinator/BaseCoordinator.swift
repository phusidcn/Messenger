//
//  BaseCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/20/21.
//

import Foundation
import UIKit

protocol BaseCoordinator {
    var childCoordinator: [BaseCoordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
