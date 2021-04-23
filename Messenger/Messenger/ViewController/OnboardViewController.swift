//
//  OnboardViewController.swift
//  Messenger
//
//  Created by huynhlamphusi on 4/20/21.
//

import UIKit
import SwiftyOnboard

class OnboardViewController: UIViewController {
    var coordinator: OnboardCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        let onboard = SwiftyOnboard(frame: self.view.frame)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(onboard)
        onboard.dataSource = self
    }

}

extension OnboardViewController: SwiftyOnboardDataSource {
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        switch index {
        case 0:
            page.title.text = "Fast messenger"
            page.subTitle.text = "Instant, blazing fast with all type of message you can send, from text chat to image or file"
            page.imageView.image = UIImage(named: "img_onboard_fast")
        case 1:
            page.title.text = "Private and secure"
            page.subTitle.text = "With end to end encription, you can trust your messenger can't read by other, include our"
            page.imageView.image = UIImage(named: "img_onboard_secure")
        case 2:
            page.title.text = "Simple and easy"
            page.subTitle.text = "Easy to use, easy to enjoy the messenger joy"
            page.imageView.image = UIImage(named: "img_onboard_easy")
        default:
            page.title.text = "Error"
        }
        return page
    }
}
