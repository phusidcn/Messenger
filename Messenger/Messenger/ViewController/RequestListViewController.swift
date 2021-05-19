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
    let requestedUser: [UserModel] = []
    var coordinator: RequestListCoordinator?
    
    override func viewDidLoad() {
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
        NetworkHandler.sharedNetworkHandler.sendGetWaitingFriendRequest() { data, response, error in
            let json = JSON(data)
            
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
        cell.textLabel?.text = user.displayName
        cell.imageView?.image = UIImage(named: "img_onboard_fast")
        return cell
    }
}
