//
//  TripSummaryCell.swift
//  riderapp
//
//  Created by Gregory Jones on 10/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class TripSummaryCell: UITableViewCell {
    
@IBOutlet var pickup_AddressLabel: UILabel!
@IBOutlet var pickup_CityLabel: UILabel!
@IBOutlet var dropoff_AddressLabel: UILabel!
@IBOutlet var dropoff_CityLabel: UILabel!
@IBOutlet var pickup_Time: UILabel!
@IBOutlet var dropoff_Time: UILabel!

   class var reuseIdentifier: String {
          return "TripSummaryCell"
      }
    
    func setupTrip(trip: TripSummary) {
        pickup_AddressLabel.text = trip.pickup_Address
        pickup_CityLabel.text = trip.pickup_City
        dropoff_AddressLabel.text = trip.dropoff_Address
        dropoff_CityLabel.text = trip.dropoff_City
        pickup_Time.text = trip.pickup_Time
        dropoff_Time.text = trip.dropoff_Time
    }
    
   
    
   
    
 
}
