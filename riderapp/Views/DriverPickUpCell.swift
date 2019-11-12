//
//  DriverPickUpCell.swift
//  riderapp
//
//  Created by Gregory Jones on 10/11/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class DriverPickUpCell: UITableViewCell {
    
    //MARK: - Properties
    
    var DriverContactNumber = "443-768-9947"
    
 
    
   //MARK: - Private functions

    let driverProfilePic: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "greg"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let driverInfo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Michael Jones", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:22) as Any, NSAttributedString.Key.foregroundColor:UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha:1)])
                   attributedText.append(NSAttributedString(string: "\nSaint Joseph's University", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
                   textView.attributedText = attributedText
                   textView.translatesAutoresizingMaskIntoConstraints = false
                   textView.textAlignment = .left
                   textView.isEditable = false
                   textView.isScrollEnabled = false
        textView.backgroundColor = .clear
                    return textView
    }()

    
    let driverVehicleInfo: UITextView = {
        let textView = UITextView()
       let attributedText = NSMutableAttributedString(string: "833XM2", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:22) as Any, NSAttributedString.Key.foregroundColor:UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha:1)])
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
      
        return textView
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           backgroundColor = .white
           self.clipsToBounds=true
        
        addSubview(driverProfilePic)
        driverProfilePic.translatesAutoresizingMaskIntoConstraints = false
        driverProfilePic.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        driverProfilePic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        driverProfilePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
        driverProfilePic.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
      
        
      
    addSubview(driverInfo)
        driverInfo.translatesAutoresizingMaskIntoConstraints = false
         driverInfo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
             driverInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        addSubview(driverVehicleInfo)
        driverVehicleInfo.translatesAutoresizingMaskIntoConstraints = false
        driverVehicleInfo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 35).isActive = true
        driverVehicleInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
            
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
    var driverPickUp: DriverPickUp? {
           
           didSet {
               
               guard let unwrappedDriverPickUp = driverPickUp else {return}
                  driverProfilePic.image = UIImage(named: unwrappedDriverPickUp.DriverProfilePic)
             let attributedText = NSMutableAttributedString(string: unwrappedDriverPickUp.DriverName, attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                   attributedText.append(NSAttributedString(string: "\n\(unwrappedDriverPickUp.DriverSchool)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
               driverInfo.attributedText = attributedText
                driverInfo.textAlignment = .left
             
            let subAttributedText = NSMutableAttributedString(string: unwrappedDriverPickUp.DriverVehicle, attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size:14) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
               
         
               driverVehicleInfo.attributedText = subAttributedText
              
                         
           }
       }
      
    
  /*  @IBAction func callDriver(_ sender: Any) {
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
           } */
    }

    
    

