//
//  BannerViewCell.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/26/21.
//

import UIKit
import SwiftyJSON

class BannerViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = .systemTeal
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
