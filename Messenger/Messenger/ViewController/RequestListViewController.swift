//
//  RequestListViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/18/21.
//

import Foundation
import UIKit
import SwiftyJSON

class RequestListViewController: UIViewController {
    let requestListView = UITableView()
    var requestedUser: [FriendRequestModel] = []
    var coordinator: RequestListCoordinator?
    
    override func viewDidLoad() {
        //requestedUser.append(UserModel(id: "00", name: "Barack OPutin", password: nil, phoneNumber: "0909090909", avatarURL: nil))
        requestedUser.append(FriendRequestModel(userid: "1", userName: "Nguyen Hong Minh", greeting: "Hello my friend", timestamp: "9210348192"))
        super.viewDidLoad()
        self.view.backgroundColor = .white
        requestListView.delegate = self
        requestListView.dataSource = self
        requestListView.register(UITableViewCell.self, forCellReuseIdentifier: "RequestTableViewCell")
        self.view.addSubview(requestListView)
        requestListView.translatesAutoresizingMaskIntoConstraints = false
        
        requestListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        requestListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        requestListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        requestListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestedUser.removeAll()
        NetworkHandler.sharedNetworkHandler.sendGetWaitingFriendRequest() { data, response, error in
            let json = JSON(data)
            if let success = json["success"].bool, success == true {
                guard let requests = json["data"].array else { return }
                for request in requests {
                    guard let userId = request["senderID"].string else { return }
                    guard let message = request["message"].string else { return }
                    guard let timestamp = request["ts"].string else { return }
                    guard let code = request["code"].int, code == 204 else { return }
                    let friendRequest = FriendRequestModel(userid: userId, userName: userId, greeting: message, timestamp: timestamp)
                    self.requestedUser.append(friendRequest)
                }
                DispatchQueue.main.async {
                    self.requestListView.reloadData()
                }
            }
        }
    }
}

extension RequestListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = requestedUser[indexPath.row]
        coordinator?.coordinatorToResponseView(withUser: user)
    }
}

extension RequestListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestedUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath)
        let user = requestedUser[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.imageView?.image = UIImage(named: "img_icon_avatar")
        return cell
    }
}
