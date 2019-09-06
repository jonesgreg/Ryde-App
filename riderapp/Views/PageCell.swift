//
//  PageCell.swift
//  riderapp
//  Description of PageCell: This defines our view object - so the page cell is responsible for presenting all of the data of this particular model which is the page model
//  Created by Gregory Jones on 6/26/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    static var identifer: String = "cellId"
    
    // MARK: - Overriden function
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var page: Page? {
        didSet {
        
        guard let unwrappedPage = page else {return} // I want to unwrapped the properties from the page struct and avoids the ! mark
            
            profileImageView.image = UIImage(named: unwrappedPage.imageName)
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size:22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
                descriptionTextView.attributedText = attributedText
                descriptionTextView.textAlignment = .center
            }
        }
    
     // MARK: - Private functions 
   
    private let profileImageView: UIImageView = {
    let imageView = UIImageView(image:#imageLiteral(resourceName: "profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   private let descriptionTextView: UITextView =  {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Create an account", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size:20) as Any, NSAttributedString.Key.foregroundColor:UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha:1)])
            attributedText.append(NSAttributedString(string: "\nAll you need is a valid school email address and a valid phone number. You can request a ride by downloading the app, go to the App store.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            textView.attributedText = attributedText
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.textAlignment = .center
            textView.isEditable = false
            textView.isScrollEnabled = false
            return textView
    }()
    
    private func setupLayout() {
       
        addSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:120).isActive = true
        
        addSubview(descriptionTextView)
         descriptionTextView.anchor(top: profileImageView.bottomAnchor, bottom: bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding:.init(top: 15, left: 32, bottom: 0, right: 32))
        
       
    
    }
   
   
}
