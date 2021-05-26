//
//  BannerModel.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/26/21.
//

import Foundation
import UIKit

class BannerModel: Decodable {
    let content: String
    let timeStamp: String
    
    init(content: String, timeStamp: String) {
        self.content = content
        self.timeStamp = timeStamp
    }
    
    private enum CodingKeys: String, CodingKey {
        case content
        case timeStamp
    }
}
