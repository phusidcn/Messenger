//
//  Data.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/3/21.
//

import Foundation
public extension Data {

    static func dataFromJSONFile(_ fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
                return data
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
}
