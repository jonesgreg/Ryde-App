//
//  Header.swift
//  riderapp
//
//  Created by Gregory Jones on 10/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

struct Header {
    
    var userProfileIcon: String
    var userName: String
    var viewProfile: String
    
    init(userProfileIcon: String, userName:String, viewProfile: String) {
       self.userProfileIcon = userProfileIcon
       self.userName = userName
       self.viewProfile = viewProfile
    }
    
}
