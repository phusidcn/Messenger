//
//  SignUpViewController.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/25/21.
//

import UIKit
import SwiftyButton
import CoreData
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    var coordinator: SignUpCoordinator?
    let iconImageView = UIImageView()
    let userNameField = UITextField()
    let phoneField = UITextField()
    let passwordField = UITextField()
    let repasswordField = UITextField()
    let registerButton = FlatButton()
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
        contentView.addSubview(phoneField)
        contentView.addSubview(passwordField)
        contentView.addSubview(repasswordField)
        contentView.addSubview(registerButton)
        self.scrollView.addSubview(contentView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
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
        
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        phoneField.topAnchor.constraint(equalTo: self.userNameField.bottomAnchor, constant: 30).isActive = true
        phoneField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        phoneField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        phoneField.placeholder = "Phone"
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 30).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "Password"
        
        repasswordField.translatesAutoresizingMaskIntoConstraints = false
        repasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        repasswordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        repasswordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        repasswordField.isSecureTextEntry = true
        repasswordField.placeholder = " Re enter password"
        
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: repasswordField.bottomAnchor, constant: 30).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        registerButton.color = .systemBlue
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(tappedToRegisterButton(sender:)), for: .touchUpInside)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func tappedToRegisterButton(sender: Any) {
        if let password = self.passwordField.text,
           let phone = self.phoneField.text,
           let username = self.userNameField.text,
           passwordField.text == repasswordField.text {
            let signupUserModel = UserModel(name: username, password: password, phoneNumber: phone)
            NetworkHandler.sharedNetworkHandler.sendSignup(with: signupUserModel) {data, response, handler in
                do {
                    let json = JSON(data)
                    if let success = json["success"].bool, success == true {
                        NetworkHandler.sharedNetworkHandler.sendLogin(with: signupUserModel) { data, response, error in
                            let json = JSON(data)
                            if let success = json["success"].bool, success == true {
                                NetworkHandler.sharedNetworkHandler.token = json["data"][0].string
                                DispatchQueue.main.async {
                                    self.coordinator?.coordinateToThreadChat()
                                }
                            }
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func keyboardWasShow(notification: Notification) {
        print("Keyboard show")
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let size = keyboardInfo.cgRectValue.size
        let bottomPosition = registerButton.frame.origin.y + registerButton.frame.size.height
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size.height - (self.view.safeAreaLayoutGuide.layoutFrame.height - bottomPosition), right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWasHide(notification: Notification) {
        print("Keyboard hide")
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
