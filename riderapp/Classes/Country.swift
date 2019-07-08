//
//  Country.swift
//  riderapp
//
//  Created by Gregory Jones on 7/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let dial_code: String
    let code: String
    
    init(code: String, dial_code: String, name: String) {
       self.code = code
       self.dial_code = dial_code
       self.name = name
    }
}
