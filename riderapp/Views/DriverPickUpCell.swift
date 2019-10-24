//
//  DriverPickUpCell.swift
//  riderapp
//
//  Created by Gregory Jones on 10/11/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class DriverPickUpCell: UITableViewCell {
    
  //  @IBOutlet var driverPickUpStatus: UILabel!
    @IBOutlet var driverProfilePic: UIImageView!
    @IBOutlet var driverName: UILabel!
    @IBOutlet var School: UILabel!
    @IBOutlet var driverVehicle: UILabel!
    @IBOutlet var cancelButton: UIButton!
    
    var DriverContactNumber = "443-768-9947"


    class var reuseIdentifier: String {
           return "DriverPickUpCell"
       }
     
     func driverPickUp(pickUp: DriverPickUp) {
      
        driverProfilePic.image = pickUp.DriverProfilePic
        driverVehicle.text = pickUp.DriverVehicle
        driverName.text = pickUp.DriverName
        School.text = pickUp.DriverSchool
    }
    
    
    @IBAction func callDriver(_ sender: Any) {
        if let phoneCallURL = URL(string: "telprompt://\(DriverContactNumber)") {

                      let application:UIApplication = UIApplication.shared
                      if (application.canOpenURL(phoneCallURL)) {
                          if #available(iOS 10.0, *) {
                              application.open(phoneCallURL, options: [:], completionHandler: nil)
                          } else {
                              // Fallback on earlier versions
                               application.openURL(phoneCallURL as URL)

                          }
                      }
                  }
           }
    }

    
    

