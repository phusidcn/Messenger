//
//  Storyboarded.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/20/21.
//

import Foundation
import UIKit

protocol Storyboarded {
    func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self);
        let className = fullName.components(separatedBy: ".")[1]
        
        
    }
}
