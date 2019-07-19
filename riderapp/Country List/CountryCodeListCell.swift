//
//  CountryCodeListCell.swift
//  riderapp
//
//  Created by Gregory Jones on 7/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class CountryCodeListCell: UITableViewCell {
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var flagLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
   
    class var reuseIdentifier: String {
        return "CountryCodeListCell"
    }
    public func feedCountry(info: Country) {
        self.nameLabel.text = info.display_name_no_e164_cc
        self.codeLabel.text = info.e164_cc
        self.flagLabel.text = info.flag
    }
        
    }
    

