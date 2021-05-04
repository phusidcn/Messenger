//
//  KingFisher.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {

    func setImage(with resource: URL?, placeholder: UIImage? = nil) {
        let optionInfo: KingfisherOptionsInfo = [
            .transition(.fade(0.25)),
            .cacheOriginalImage
        ]

        kf.setImage(with: resource, placeholder: placeholder, options: optionInfo)
    }
}
