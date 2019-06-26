//
//  WelcomeScreenViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/25/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    
    /* Profile Image */
    
   private let profileImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /* Text Description */
    
   private let descriptionTextView: UITextView =  {
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
    
    /* Ride Now Button */
   private let rideNowButton: UIButton = {
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
    
    
    /* Page Control */
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 6
        pc.currentPageIndicatorTintColor = Colors.darkOrange
        pc.pageIndicatorTintColor = UIColor.lightGray
       
        return pc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //here's our entry point into our app
        view.addSubview(profileImageView)
        view.addSubview(descriptionTextView)
        view.addSubview(rideNowButton)
        setupBottomControls()
        //Change background color of the view controller
        view.backgroundColor = .init(red: 248/250, green: 248/250, blue: 248/250, alpha:1)
        setupLayout()
        
        
       
    }
    
    fileprivate func setupBottomControls() {
       let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        bottomControlsStackView.bottomAnchor.constraint(equalTo: rideNowButton.topAnchor, constant: -20).isActive = true
        
   
        
        
    }
    
     fileprivate func setupLayout() {
       /* Profile Image Layout */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    
        
        
        /* Description Text View Layout */
        descriptionTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
       
    
        /* Button Layout  */
        // rideNowButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: -80).isActive = true
        rideNowButton.bottomAnchor.constraint(equalTo:descriptionTextView.bottomAnchor, constant: -35).isActive = true
        rideNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        rideNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        rideNowButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
 
    
      }
    
    
    
}
