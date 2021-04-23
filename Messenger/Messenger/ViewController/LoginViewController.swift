//
//  LoginViewController.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/22/21.
//

import UIKit

class LoginViewController: UIViewController {
    let iconImageView = UIImageView()
    let userNameField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)
    let signupButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(userNameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
        
        iconImageView.topAnchor.constraint	
    }

}
