//
//  TripSummary.swift
//  riderapp
//
//  Created by Gregory Jones on 10/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.

import GoogleMaps

struct TripSummary {
    
    let pickup_Address: String
    let pickup_City: String
    let pickup_Time: String
    
    let dropoff_Address: String
    let dropoff_City: String
    let dropoff_Time: String
    
    
   init(pickup_Address: String, pickup_City: String, pickup_Time: String, dropoff_Address:String, dropoff_City: String, dropoff_Time: String) {
        
        self.pickup_Address = pickup_Address
        self.pickup_City = pickup_City
        self.pickup_Time = pickup_Time
        self.dropoff_Address = dropoff_Address
        self.dropoff_City = dropoff_City
        self.dropoff_Time = dropoff_Time
    } 
    
}
