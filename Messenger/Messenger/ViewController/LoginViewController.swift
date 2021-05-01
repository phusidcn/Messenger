//
//  LoginViewController.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/22/21.
//

import UIKit
import SwiftyButton

class LoginViewController: UIViewController {
    var coordinator: LoginCoordinator?
    let iconImageView = UIImageView()
    let userNameField = UITextField()
    let passwordField = UITextField()
    let loginButton = FlatButton()
    let signupButton = FlatButton()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        let contentView = UIView()
        contentView.addSubview(iconImageView)
        contentView.addSubview(userNameField)
        contentView.addSubview(passwordField)
        contentView.addSubview(loginButton)
        contentView.addSubview(signupButton)
        self.scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
        iconImageView.image = UIImage(named: "img_icon_chat")
        
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        userNameField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30).isActive = true
        userNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        userNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        userNameField.placeholder = "User name"
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 30).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "Password"
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.color = .systemBlue
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(tappedToSignInButton(sender:)), for: .touchUpInside)
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        signupButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 20).isActive = true
        signupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        signupButton.color = .systemPink
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.addTarget(self, action: #selector(tappedToSignUpButton(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWasShow(notification: Notification) {
        print("Keyboard show")
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let size = keyboardInfo.cgRectValue.size
        let bottomPosition = signupButton.frame.origin.y + signupButton.frame.size.height
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size.height - (self.view.safeAreaLayoutGuide.layoutFrame.height - bottomPosition), right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWasHide(notification: Any) {
        print("Keyboard hide")
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc func tappedToSignUpButton(sender: UIButton) {
        coordinator?.coordinateToSignUp()
    }
    
    @objc func tappedToSignInButton(sender: UIButton) {
        coordinator?.coordinateToThreadChat()
    }

}
