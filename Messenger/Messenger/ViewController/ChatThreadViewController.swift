//
//  ChatThreadViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 27/04/2021.
//

import UIKit

class ChatThreadViewController: UIViewController {
    var coordinator: ChatThreadCoordinator?
    let threadView = UITableView()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        threadView.delegate = self
        threadView.dataSource = self
        threadView.register(UITableViewCell.self, forCellReuseIdentifier: "ChatThreadViewCell")
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension ChatThreadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension ChatThreadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThreadViewCell", for: indexPath)
        cell.textLabel?.text = "Maria"
        cell.detailTextLabel?.text = "Robin Hood"
        cell.imageView?.image = UIImage(named: "img_onboard_fast")!
        return cell
    }
}
