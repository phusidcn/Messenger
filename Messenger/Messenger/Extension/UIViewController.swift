//
//  UIViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
import UIKit

extension UIViewController {

    public func addBackBarButton() {
        let image = UIImage(named: "ic_nav_back")
        let button = UIBarButtonItem(image: image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(tappedOnBackBarButton(sender:)))
        navigationItem.leftBarButtonItem = button
    }

    @objc open func tappedOnBackBarButton(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}
