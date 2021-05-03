//
//  ChatWindowViewController.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/1/21.
//

import UIKit
import ChatViewController

class ChatWindowViewController: ChatViewController {
    var cooridinator: ChatWindowCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

}
