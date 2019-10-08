//
//  locations.swift
//  riderapp
//
//  Created by Gregory Jones on 9/28/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

struct Location {
    
    var attributedImage: NSMutableAttributedString?
    var attributedTitle: NSMutableAttributedString?
    var attributedDesc: NSMutableAttributedString?
    var allAttributedName: NSMutableAttributedString?
    
    
    var image: String
    var title: String
    var desc: String
    var coordinate: CLLocationCoordinate2D
    var location: String
    
   
    init(image: String, title: String, desc: String, coordinate: CLLocationCoordinate2D, location: String) {
        self.image = image
        self.title = title
        self.desc = desc
        self.coordinate = coordinate
        self.location = location
        
    }
    
    public mutating func getFormatedText() -> NSMutableAttributedString {
       allAttributedName = NSMutableAttributedString()
       allAttributedName!.append(attributedImage!)
       allAttributedName!.append(attributedTitle!)
       allAttributedName!.append(NSMutableAttributedString(string: ", "))
       allAttributedName!.append(attributedDesc!)
        
        return allAttributedName!
    }
    
    public func getStringText() -> String{
        return "\(image), \(title), \(desc)"
    }
   
}
