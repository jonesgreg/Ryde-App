//
//  ProfileOptionCell.swift
//  riderapp
//
//  Created by Gregory Jones on 9/22/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class ProfileOptionCell: UITableViewCell {
    
    //MARK: - Properties
    
    let iconImageView: UIImageView = {
         let iv = UIImageView()
             iv.contentMode = .scaleAspectFit
             iv.clipsToBounds = true
             iv.width(constant: 22)
             iv.height(constant: 22)
         return iv
     }()
     
     let descriptionLabel: UILabel = {
         let label = UILabel()
             label.textColor = .black
             label.font = UIFont(name: Fonts.gilroyMedium, size: 16)
             label.text = "Sample text"
             return label
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
            
            addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
            iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            
            addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
            
            
            addSubview(forwardButton)
            forwardButton.translatesAutoresizingMaskIntoConstraints = false
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
            forwardButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
            forwardButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
            
        
        
        }
        
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

