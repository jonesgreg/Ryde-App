//
//  ProfileOption.swift
//  riderapp
//
//  Created by Gregory Jones on 9/22/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

enum ProfileOption: Int, CustomStringConvertible {
    
    case Email
    case Phone
    case Home
    case School
    
    
    var description: String {
        switch self {
        case .Email: return "School Email"
        case .Phone: return "Phone"
        case .Home: return "Home"
        case .School: return "School"
       }
    }
    
    var image: UIImage {
        switch self {
        case .Email: return UIImage(named: "setting_emails") ?? UIImage()
        case .Phone: return UIImage(named: "call") ?? UIImage()
        case .Home:
            return UIImage(named: "setting_home") ?? UIImage()
        case .School:
            return UIImage(named: "setting_school") ?? UIImage()
        }
    }
}
