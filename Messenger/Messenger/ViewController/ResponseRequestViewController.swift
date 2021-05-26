//
//  ResponseRequestViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/16/21.
//

import Foundation
import UIKit
import SwiftyJSON
import SwiftyButton

class ResponseRequestViewController: UIViewController {
    
    var requestedUser: FriendRequestModel?
    var coordinator: ResponseRequestCoordinator?
    let avatarImageView = UIImageView()
    let requestingUserNameView = UILabel()
    let greetingView = UITextField()
    let acceptButton = FlatButton()
    let deninedButton = FlatButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(avatarImageView)
        self.view.addSubview(requestingUserNameView)
        self.view.addSubview(greetingView)
        self.view.addSubview(acceptButton)
        self.view.addSubview(deninedButton)
        self.view.backgroundColor = .white
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        requestingUserNameView.translatesAutoresizingMaskIntoConstraints = false
        greetingView.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        deninedButton.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: self.view.frame.size.width / 4).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        avatarImageView.image = UIImage(named: "img_icon_avatar")
        
        requestingUserNameView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30).isActive = true
        requestingUserNameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        requestingUserNameView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        requestingUserNameView.textAlignment = .center
        requestingUserNameView.text = requestedUser?.userName
        
        greetingView.topAnchor.constraint(equalTo: requestingUserNameView.bottomAnchor, constant: 30).isActive = true
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        greetingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        greetingView.text = "Hello, I want to make friend with you"
        
        acceptButton.topAnchor.constraint(equalTo: greetingView.bottomAnchor, constant: 30).isActive = true
        acceptButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        acceptButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -20).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        acceptButton.color = .systemBlue
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.addTarget(self, action: #selector(tappedToAcceptButton(sender:)), for: .touchUpInside)
        
        deninedButton.topAnchor.constraint(equalTo: greetingView.bottomAnchor, constant: 30).isActive = true
        deninedButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 20).isActive = true
        deninedButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        deninedButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        deninedButton.color = .systemRed
        deninedButton.setTitle("Deny", for: .normal)
        deninedButton.addTarget(self, action: #selector(tappedToDenyButton(sender:)), for: .touchUpInside)
    }
    
    @objc func tappedToAcceptButton(sender: UIButton) {
        //---Log---
        let log = TrackingModel(labelControl: "Accept friendship", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
        TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
        //---Log---
        ChatSocket.sharedChatSocket.sendFriendshipResponse(to: requestedUser!.userId, greetingMessage: greetingView.text!)
    }
    
    @objc func tappedToDenyButton(sender: UIButton) {
        //---Log---
        let log = TrackingModel(labelControl: "Denied friendship", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
        TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
        //---Log---
    }
}
