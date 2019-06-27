//
//  PageCell.swift
//  riderapp
//
//  Created by Gregory Jones on 6/26/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
    let imageView = UIImageView(image:#imageLiteral(resourceName: "Profile"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()
    
    let descriptionTextView: UITextView =  {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Create an account", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size:22) as Any, NSAttributedString.Key.foregroundColor:UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha:1)])
        
        attributedText.append(NSAttributedString(string: "\n\nAll you need is a valid school email address and a valid phone number. You can request a ride by downloading the app, go to the App store.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let rideNowButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.darkOrange.cgColor
        button.backgroundColor = Colors.darkOrange
        button.setTitle("Ryde Now", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
       
        addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    profileImageView.widthAnchor.constraint(equalToConstant:120).isActive = true
      profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
       
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        addSubview(rideNowButton)
   rideNowButton.bottomAnchor.constraint(equalTo:descriptionTextView.bottomAnchor, constant: -35).isActive = true
        rideNowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        rideNowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        rideNowButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
