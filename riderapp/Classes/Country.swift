//
//  Country.swift
//  riderapp
//
//  Created by Gregory Jones on 7/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import Foundation

struct Initial: Decodable {
    var countries: [String: Country]
    
    init(countries:[String: Country]) {
        self.countries = countries
    }
}

struct Country: Decodable {
    var name: String?
    var phone: String?
    var emoji: String?
    
    init(name: String, phone: String, emoji: String) {
        self.name = name
        self.phone = phone
        self.emoji = emoji
    }
    
    
}




    
    
    




   
    

    




   







