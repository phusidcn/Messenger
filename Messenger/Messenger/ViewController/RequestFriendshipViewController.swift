//
//  RequestFriendshipViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/4/21.
//

import UIKit
import SwiftyButton

class RequestFriendshipViewController: UIViewController {
    
    var userModel: UserModel?
    var coordinator: RequestFriendshipCoordinator?
    let imageView = UIImageView()
    let nameView = UILabel()
    let greetingField = UITextField()
    let requestButton = FlatButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(nameView)
        self.view.addSubview(greetingField)
        self.view.addSubview(requestButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        greetingField.translatesAutoresizingMaskIntoConstraints = false
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width / 2).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        nameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        nameView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameView.textAlignment = .center
        nameView.attributedText = NSAttributedString(string: "Marai Niken", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .black)])

        
        greetingField.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 50).isActive = true
        greetingField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        greetingField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        greetingField.placeholder = "Greeting friend request"
        greetingField.text = "Hello, I want to make friend with you"
        
        requestButton.topAnchor.constraint(equalTo: greetingField.bottomAnchor, constant: 30).isActive = true
        requestButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        requestButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        requestButton.color = .systemBlue
        requestButton.setTitle("Send friend request", for: .normal)
        requestButton.addTarget(self, action: #selector(tappedToSendRequest(_:)), for: .touchUpInside)
    }
    
    @objc func tappedToSendRequest(_ sender: UIButton) {
        guard let userId = self.userModel?.id else { return }
        ChatSocket.sharedChatSocket.sendFriendshipRequest(to: userId, greetingMessage: "Hello, I want to make friend with you")
    }
}
