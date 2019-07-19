//
//  JSONReader.swift
//  riderapp
//
//  Created by Gregory Jones on 7/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//


import Foundation

struct JSONReader {
    static func countries() -> Countries? {
        let url = Bundle.main.url(forResource: "country-codes.json", withExtension: nil)
        let data = try! Data.init(contentsOf: url!)
        do {
            return try JSONDecoder().decode(Countries.self, from: data)
        } catch {
            // Handle Error
            debugPrint(error)
            return nil
        }
    }
}
