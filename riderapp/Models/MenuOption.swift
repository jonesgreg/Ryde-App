//
//  MenuOption.swift
//  riderapp
//
//  Created by Gregory Jones on 9/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case EditProfile
    case RideHistory
    case BecomeADriver
    case Help
    case Settings
    case Call
    case TermsOfUse
    case PrivacyPolicy
    case SoftwareLicense
    case LogOut
    
    var description: String {
        switch self  {
        case .EditProfile: return "Edit Profile"
        case .RideHistory: return "Ride History"
        case .BecomeADriver: return "Become a driver"
        case .Help: return "Help"
        case .Settings: return "Settings"
        case .Call: return "Call"
        case .TermsOfUse: return "Terms Of Use"
        case .PrivacyPolicy: return "Privacy Policy"
        case .SoftwareLicense: return "Software License"
        case .LogOut: return "Log out"
        }
    }
    
}
