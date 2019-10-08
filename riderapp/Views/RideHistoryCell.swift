//
//  RideHistoryCell.swift
//  riderapp
//
//  Created by Gregory Jones on 10/4/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class RideHistoryCell: UITableViewCell {
    
     let profileIcon: UIImageView = {
         let iv = UIImageView(image: #imageLiteral(resourceName: "profile"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.width(constant: 40)
        iv.height(constant: 40)
        return iv
    }()
    
   /* let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.gilroyBold, size: 14)
        label.text = "Sample text"
        return label
        
    }()
    
    let tripDistanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.gilroyRegular, size: 12)
        label.text = "Sample text"
        return label
  
   }() */
    
    let tripDetails: UITextView = {
        let textView = UITextView()
             let attributedText = NSMutableAttributedString(string: "Aug 03, 4:51pm ", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                    attributedText.append(NSAttributedString(string: "\n2.2mi, 5mins", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
                   textView.attributedText = attributedText
                   textView.translatesAutoresizingMaskIntoConstraints = false
                   textView.textAlignment = .left
                   textView.isEditable = false
                   textView.isScrollEnabled = false
                   textView.backgroundColor = .clear
                   return textView
    }()
    
    let forwardButton: UIButton = {
           let button = UIButton()
               button.layer.masksToBounds = false
               button.setImage(#imageLiteral(resourceName: "settings_forward_button"), for: .normal)
               button.width(constant: 18)
               button.height(constant: 18)
           return button
  }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     
     backgroundColor = .white
        selectionStyle = .default
    
     
     addSubview(profileIcon)
     profileIcon.translatesAutoresizingMaskIntoConstraints = false
   
    profileIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
    profileIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26).isActive = true
     
    addSubview(tripDetails)
         tripDetails.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
         tripDetails.leadingAnchor.constraint(equalTo: profileIcon.trailingAnchor, constant: 12).isActive = true
        
        
    addSubview(forwardButton)
    forwardButton.translatesAutoresizingMaskIntoConstraints = false
    forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
    forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    forwardButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
    forwardButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
 }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var trip: RideHistory? {
        
        didSet {
            guard let unwrappedTrip = trip else {return}
            // I want to unwrapped the properties from the Ride History struct and avoids the ! mark
            
            profileIcon.image = UIImage(named: unwrappedTrip.profileImage)
            let attributedText = NSMutableAttributedString(string: unwrappedTrip.date,attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            attributedText.append(NSAttributedString(string: "\n\(unwrappedTrip.tripDistance)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            tripDetails.attributedText = attributedText
            tripDetails.textAlignment = .left
        }
    }
}
