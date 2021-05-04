//
//  SelectionStyleCell.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
import UIKit

class SelectionStyleCell: UITableViewCell {

    var chatBarStyleTitle: UILabel!
    var useImagePickerDefaultSwitch: UISwitch!
    var showConversationButton: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.backgroundColor = .white
    }
}
