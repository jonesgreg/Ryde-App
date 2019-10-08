//
//  RideHistoryOption.swift
//  riderapp
//
//  Created by Gregory Jones on 10/4/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

struct RideHistory {
    
    var profileImage: String
    var date: String
    var tripDistance: String
    
    init(profileImage: String, date: String, tripDistance: String) {
        self.profileImage = profileImage
        self.date = date
        self.tripDistance = tripDistance
    }
    
    
    
    
}
