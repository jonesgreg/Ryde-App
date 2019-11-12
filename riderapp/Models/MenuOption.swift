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
   
    case Help
    case Settings
   
    
    var description: String {
        switch self {
        case .GetARide: return "Get a ride"
        case .RideHistory: return "Ride history"
        case .Help: return "Help"
        case .Settings: return "Settings"
       
      }
    }
    
    var image: UIImage {
        switch self {
        case .GetARide: return UIImage(named: "menu_car") ?? UIImage()
        case .RideHistory: return UIImage(named: "menu_history") ?? UIImage()
        case .Help: return UIImage(named: "menu_help") ?? UIImage()
        case .Settings: return UIImage(named: "menu_setting") ?? UIImage()
    }
        
    }
    
    
}
