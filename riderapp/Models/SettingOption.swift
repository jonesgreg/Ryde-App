//
//  Setting.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

enum SettingOptions: Int, CustomStringConvertible {
    
    case Profile
    case Email
    case phoneNumber
    case Home
    case DriveAndEarn
    case Privacy
    case TermsOfUse
    
    
    
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Email: return "School Email"
        case .phoneNumber: return "Phone Number"
        case .Home: return "Home"
        case .DriveAndEarn: return "Drive with Fleet"
        case .Privacy: return "Privacy"
        case .TermsOfUse: return "Terms of Use"
        
       
    }
  }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "setting_profile") ?? UIImage()
        case .Email:return UIImage(named: "setting_emails") ?? UIImage()
        case .phoneNumber:return UIImage(named: "settings_phone") ?? UIImage()
        case .Home:return UIImage(named: "setting_home") ?? UIImage()
        case .DriveAndEarn:  return UIImage(named: "drivewithus") ?? UIImage()
        case .Privacy: return UIImage(named: "settings_privacy") ?? UIImage()
        case .TermsOfUse: return UIImage(named: "setting_terms") ?? UIImage()
        
       
       }
    }

}


