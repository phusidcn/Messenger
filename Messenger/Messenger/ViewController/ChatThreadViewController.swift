//
//  ChatThreadViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 27/04/2021.
//

import UIKit
import SwiftyJSON

class ChatThreadViewController: UIViewController {
    var coordinator: ChatThreadCoordinator?
    let threadView = UITableView()
    let searchBar = UISearchBar()
    var searchWorkItem: DispatchWorkItem?
    var searchResultList: [UserModel] = []
    var friendList: [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        threadView.delegate = self
        threadView.dataSource = self
        threadView.register(UITableViewCell.self, forCellReuseIdentifier: "ChatThreadViewCell")
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        self.view.addSubview(threadView)
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchBar.placeholder = "Search friend, message,..."
        
        threadView.translatesAutoresizingMaskIntoConstraints = false
        threadView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        threadView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        threadView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        threadView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        ChatSocket.sharedChatSocket.connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NetworkHandler.sharedNetworkHandler.sendFriendListRequest() { data, response, error in
            let json = JSON(data)
            if let success = json["success"].bool, success == true {
                guard let friendList = json["data"].array else { return }
                for user in friendList {
                    guard let id = user["_id"].string else {
                        print("Error")
                        return
                    }
                    guard let name = user["Name"].string else {
                        print("error")
                        return
                    }
                    guard let phone = user["Phone"].string else {
                        print("Error")
                        return
                    }
                    let friend = UserModel(id: id, name: name, password: nil, phoneNumber: phone, avatarURL: nil)
                    self.friendList.append(friend)
                }
                DispatchQueue.main.async {
                    self.threadView.reloadData()
                }
            }
        }
    }
}

extension ChatThreadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if false {
            self.coordinator?.coordinateToFriendRequestWithUser(searchResultList[indexPath.row])
        } else {
            let userModel = friendList[indexPath.row]
            self.coordinator?.coordinateToChatWindowsWith(userModel: userModel)
        }
    }
}

extension ChatThreadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchEntry = self.searchBar.text, searchEntry.count > 0 {
            return self.searchResultList.count
        } else {
            return self.friendList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let searchEntry = searchBar.text, searchEntry.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
            let result = searchResultList[indexPath.row]
            cell.textLabel?.text = result.displayName
            cell.imageView?.image = UIImage(named: "img_onboard_fast")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
            let user = friendList[indexPath.row]
            cell.textLabel?.text = user.displayName
            cell.imageView?.image = UIImage(named: "img_onboard_fast")!
            return cell
        }
    }
}

extension ChatThreadViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchEntry = searchBar.text else { return }
        self.searchWorkItem?.cancel()
        self.searchWorkItem = DispatchWorkItem() {
            if searchEntry.count < 9 {
                for user in self.friendList {
                    let phone = user.phoneNumber
                    if phone.contains(searchEntry) {
                        self.searchResultList.append(user)
                    }
                }
                DispatchQueue.main.async {
                    self.threadView.reloadData()
                }
            } else {
                NetworkHandler.sharedNetworkHandler.sendSearch(withSearchEntry: searchEntry) { data, response, error in
                    let json = JSON(data)
                    if let success = json["success"].bool, success == true {
                        guard let friendList = json["data"].array else { return}
                        for json in friendList {
                            let user = UserModel(id: json["_id"].string, name: json["Name"].string, password: nil, phoneNumber: searchEntry, avatarURL: nil)
                            self.searchResultList.append(user)
                        }
                        DispatchQueue.main.async {
                            self.threadView.reloadData()
                        }
                    }
                }
            }
        }
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 0.58, execute: self.searchWorkItem!)
    }
}
