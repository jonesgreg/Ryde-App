//
//  MenuOption.swift
//  riderapp
//
//  Created by Gregory Jones on 9/13/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case GetARide
    case RideHistory
    case Call
    case DriveAndEarn
    case Help
    case Settings
   
    
    var description: String {
        switch self {
        case .GetARide: return "Get a ride"
        case .RideHistory: return "Ride history"
        case .Call: return "Call"
        case .DriveAndEarn: return "Drive and earn"
        case .Help: return "Help"
        case .Settings: return "Settings"
       
      }
    }
    
    var image: UIImage {
        switch self {
        case .GetARide: return UIImage(named: "getaride") ?? UIImage()
        case .RideHistory: return UIImage(named: "ridehistory") ?? UIImage()
        case .Call: return UIImage(named: "call") ?? UIImage()
        case .DriveAndEarn: return UIImage(named: "driveandearn") ?? UIImage()
        case .Help: return UIImage(named: "help") ?? UIImage()
        case .Settings: return UIImage(named: "settings") ?? UIImage()
    }
        
    }
    
    
}
