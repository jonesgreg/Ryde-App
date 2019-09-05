//
//  MenuBar.swift
//  riderapp
//
//  Created by Gregory Jones on 9/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

protocol menuBarDelegate: class {
    func menuBarDidSelectRow(row: Row)
}


enum Row: String {
    case editProfile
    case rideHistory
    case becomeADriver
    case help
    case settings
    case call
    case termsOfUse
    case privacyPolicy
    case softwareLicense
    case logOut
    case none
    
    init(row: Int) {
        switch row  {
        case 0: self = .editProfile
        case 1: self = .rideHistory
        case 2: self = .becomeADriver
        case 3: self = .help
        case 4: self = .settings
        case 5: self = .call
        case 6: self = .termsOfUse
        case 7: self = .privacyPolicy
        case 8: self = .softwareLicense
        case 9: self = .logOut
        default: self = .none
          
        }
    }
}
