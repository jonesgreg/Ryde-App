//
//  Country.swift
//  riderapp
//
//  Created by Gregory Jones on 7/22/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let e164_cc: String
    let iso2_cc: String
    let e164_sc: Int
    let geographic: Bool
    let level: Int
    let name: String
    let example: String
    let display_name: String
    let full_example_with_plus_sign: String?
    let display_name_no_e164_cc: String
    let e164_key: String
}

fileprivate let baseScalar: UInt32 = 127397

extension Country {
    var flag: String {
        return iso2_cc.unicodeScalars.compactMap { String(UnicodeScalar(baseScalar + $0.value)!) }.joined()
    }
}


