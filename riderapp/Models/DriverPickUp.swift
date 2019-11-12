//
//  DriverPickUp.swift
//  riderapp
//
//  Created by Gregory Jones on 10/11/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

struct DriverPickUp {
    let DriverProfilePic: String
    let DriverVehicle: String
    let DriverName: String
    let DriverSchool: String
    
   init(DriverProfilePic: String, DriverVehicle: String, DriverName:String, DriverSchool: String) {
        
        self.DriverProfilePic = DriverProfilePic
        self.DriverVehicle = DriverVehicle
        self.DriverName = DriverName
        self.DriverSchool = DriverSchool
       
    }
    
}
