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
    var showList: [UserModel] = []
    var bannerModel: BannerModel?
    var dismissedBanner: Bool = false

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
        //---Log---
        let log = TrackingModel(labelControl: "Login Button", event: "touchUpInside", timestamp: (Date().timeIntervalSince1970))
        TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
        //---Log---
        ChatSocket.sharedChatSocket.connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(tappedToLogoutButton(_:)))
        getBannerContent()
        updateThreadChat()
    }
    
    func getBannerContent() {
        NetworkHandler.sharedNetworkHandler.sendGetBannerRequest() { data, response, error in
            let json = JSON(data)
            if let success = json["success"].bool, success == true {
                guard let items = json["data"].array else { return }
                for item in items {
                    guard let code = item["code"].int, code == 300 else { return }
                    guard let success = item["success"].bool, success == false else { return }
                    guard let message = item["message"].string else { return }
                    guard let id = item["id"].string else { return }
                    CoreContext.shareCoreContext.bannerId = id
                    self.bannerModel = BannerModel(content: message, timeStamp: "\(Date().timeIntervalSince1970)")
                }
                DispatchQueue.main.async {
                    self.threadView.reloadData()
                }
            }
        }
    }
    
    func updateThreadChat() {
        NetworkHandler.sharedNetworkHandler.sendGetFriendList() { data, response, error in
            let json = JSON(data)
            if let success = json["success"].bool, success == true {
                guard let userList = json["data"].array else { return }
                for user in userList {
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
                    
                    var isAppear = false
                    for friend in self.showList {
                        if friend.id == id {
                            isAppear = true
                        }
                    }
                    if !isAppear {
                        let friend = UserModel(id: id, name: name, password: nil, phoneNumber: phone, birthDay: nil, avatarURL: nil)
                        self.showList.append(friend)
                        self.friendList.append(friend)
                    }
                    
                }
                DispatchQueue.main.async {
                    self.threadView.reloadData()
                }
            }
        }
    }
    
    func isFriend(user: UserModel) -> Bool {
        for friend in friendList {
            if friend.id == user.id {
                return true
            }
        }
        return false
    }
    
    func isSearching() -> Bool {
        guard let searchEntry = self.searchBar.text else { return false }
        return searchEntry.count > 0
    }
    
    @objc func tappedToLogoutButton(_ sender: Any?) {
        //---Log---
        let log = TrackingModel(labelControl: "Logout Button", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
        TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
        //---Log---
        NetworkHandler.sharedNetworkHandler.sendLogout(completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ChatThreadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user: UserModel
        if self.bannerModel != nil, !self.dismissedBanner {
            if indexPath.row == 0 {
                self.dismissedBanner = true
                //---Log---
                let log = TrackingModel(labelControl: "Banner", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
                TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
                //---Log---
                NetworkHandler.sharedNetworkHandler.sendUserDismissBanner() { data, response, error in
                    //print("Data: \(data ?? Data()) - Response: \(response ?? URLResponse()) - Error: \(error ?? E)")
                }
                tableView.reloadData()
                return
            } else {
                user = showList[indexPath.row - 1]
            }
        } else {
            user = showList[indexPath.row]
        }
        if isFriend(user: user) {
//            let userModel = user[indexPath.row]
            //---Log---
            let log = TrackingModel(labelControl: "\(user.id)", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
            TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
            //---Log---
            self.coordinator?.coordinateToChatWindowsWith(userModel: user)
        } else {
            //---Log---
            let log = TrackingModel(labelControl: "\(user.id)", event: "touchUpInside", timestamp: Date().timeIntervalSince1970)
            TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
            //---Log---
            self.coordinator?.coordinateToFriendRequestWithUser(user)
        }
    }
}

extension ChatThreadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let bannerCount = (self.bannerModel != nil && !self.dismissedBanner) ? 1 : 0
        return showList.count + bannerCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let bannerModel = self.bannerModel, !self.dismissedBanner, indexPath.row == 0 {
            let attributedString = NSAttributedString(string: bannerModel.content)
            return attributedString.height(containerWidth: tableView.contentSize.width - 300)
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if isSearching() {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
//            let result = searchResultList[indexPath.row]
//            cell.textLabel?.text = result.displayName
//            cell.imageView?.image = UIImage(named: "img_onboard_fast")
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
//            let user = friendList[indexPath.row]
//            cell.textLabel?.text = user.displayName
//            cell.imageView?.image = UIImage(named: "img_onboard_fast")!
//            return cell
//        }
        if let banner = self.bannerModel, !self.dismissedBanner {
            if indexPath.row == 0 {
                let cell = BannerViewCell()
                cell.textLabel?.attributedText = NSAttributedString(string: banner.content, attributes: nil)
                cell.imageView?.image = UIImage(named: "img_icon_attention")
                cell.textLabel?.numberOfLines = 0
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
                let user = showList[indexPath.row - 1]
                cell.textLabel?.text = user.displayName
                cell.imageView?.image = UIImage(named: "img_icon_avatar")
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
            let user = showList[indexPath.row]
            cell.textLabel?.text = user.displayName
            cell.imageView?.image = UIImage(named: "img_icon_avatar")
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
        showList.removeAll()
        guard let searchEntry = searchBar.text else { return }
        self.searchWorkItem?.cancel()
        self.searchWorkItem = DispatchWorkItem() {
            if searchEntry.count < 9 {
                let log = TrackingModel(labelControl: "SearchBox", event: "Search", note: searchEntry, timestamp: Date().timeIntervalSince1970)
                TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
                for user in self.friendList {
                    let phone = user.phoneNumber
                    if phone.contains(searchEntry) {
                        self.showList.append(user)
                    }
                }
                DispatchQueue.main.async {
                    self.threadView.reloadData()
                }
            } else {
                let log = TrackingModel(labelControl: "SearchBox", event: "Search", note: searchEntry, timestamp: Date().timeIntervalSince1970)
                TrackingFlowManager.sharedTrackingFlowManager.addTrackingLog(log)
                NetworkHandler.sharedNetworkHandler.sendSearch(withSearchEntry: searchEntry) { data, response, error in
                    let json = JSON(data)
                    if let success = json["success"].bool, success == true {
                        guard let friendList = json["data"].array else { return}
                        for json in friendList {
                            let user = UserModel(id: json["_id"].string, name: json["Name"].string, password: nil, phoneNumber: searchEntry, birthDay: nil, avatarURL: nil)
                            self.showList.append(user)
                        }
                        DispatchQueue.main.async {
                            self.threadView.reloadData()
                        }
                    }
                }
            }
        }
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 0.6, execute: self.searchWorkItem!)
    }
}
