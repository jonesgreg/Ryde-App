//
//  Protocols.swift
//  riderapp
//
//  Created by Gregory Jones on 9/13/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

protocol menuBarViewDelegate: class {
    func handleMenuToggle(forMenuOption: MenuOption?)
   
}


protocol HeaderTableViewCellDelegate: class {
   func didSelectHeaderViewCell(Selected: Bool, UserHeader: HeaderViewCell)
}

protocol SettingsDelegate: class {
    func handleSettingsToggle(forSettingOption: SettingOptions?)
}

protocol ProfileDelegate: class {
    func handleProfilesToggle(forProfileOption: ProfileOption?)
}

protocol SelectedVehicleDelegate: class {
    func handleHomeDissmial(SelectedVehicle: Int)
}

protocol AnimateSelectVehicleDelegate: class {
    func handleAnimationSelectVehicle(animateVehicle: Int)
}

protocol AnimateDriverPickUpDelegate: class {
   func handleAnimationDriverPick()
}

protocol dismissDriverPickUpView: class {
    func handleDismissDriverPickUp()
}
