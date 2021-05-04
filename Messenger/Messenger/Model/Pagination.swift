//
//  Pagination.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation

struct Pagination: Decodable {

    let page: Int
    let pageSize: Int
    let total: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "page_size"
        case total
    }

    func hasMore() -> Bool {
        return page * pageSize < total
    }
}
