//
//  BaseCoordinator.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/20/21.
//

import Foundation
import UIKit

protocol BaseCoordinator {
    func start()
    func coordinate(to coordinator: BaseCoordinator)
}

extension BaseCoordinator {
    func coordinate(to coordinator: BaseCoordinator) {
        coordinator.start()
    }
}
