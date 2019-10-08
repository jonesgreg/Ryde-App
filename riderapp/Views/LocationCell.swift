//
//  LocationCelll.swift
//  riderapp
//
//  Created by Gregory Jones on 9/30/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    
    //MARK - Properties

   private let locationIcon: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "green_home"))
        iv.contentMode = .scaleAspectFit
        iv.width(constant: 30)
       iv.height(constant: 30)
      iv.translatesAutoresizingMaskIntoConstraints = false
       iv.clipsToBounds = true
       return iv
   }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
            label.textColor = .black
            label.font = UIFont(name: Fonts.gilroyMedium, size: 15)
            label.text = "Sample text"
            return label
    }()
   
    let locationSubLabel: UILabel = {
           let label = UILabel()
               label.textColor = .black
               label.font = UIFont(name: Fonts.gilroyRegular, size: 13)
               label.text = "Sample text"
            return label
    }()
    
 
    
    private let locationText: UITextView =  {
          let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "LaFarge Residence Hall", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size:15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
              attributedText.append(NSAttributedString(string: "\n2425 Cardinal Ave", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
              textView.attributedText = attributedText
              textView.translatesAutoresizingMaskIntoConstraints = false
              textView.textAlignment = .left
              textView.isEditable = false
              textView.isScrollEnabled = false
              return textView
      }()
      
    

    
    private lazy var locationSelection: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationIcon, locationLabel])
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = 8.0
            return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .default
        
        addSubview(locationIcon)
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
        locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26).isActive = true
     
      /*  addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 12).isActive = true
        
        addSubview(locationSubLabel)
        locationSubLabel.translatesAutoresizingMaskIntoConstraints = false
        locationSubLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        locationSubLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 12).isActive = true */
        
        
     addSubview(locationText)
     locationText.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
     locationText.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 12).isActive = true
             
        
        
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
       var location: Location? {
           didSet {
               guard let unwrappedLocation = location else {return} // I want to unwrapped the properties from the location struct and avoids the ! mark
               
               locationIcon.image = UIImage(named:unwrappedLocation.image)
                let attributedText = NSMutableAttributedString(string: unwrappedLocation.title, attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size:16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                attributedText.append(NSAttributedString(string: "\n\(unwrappedLocation.location)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
          locationText.attributedText = attributedText
                        locationText.textAlignment = .left
                        
           }
       }
    
    
     
}
