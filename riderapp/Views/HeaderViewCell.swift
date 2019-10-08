//
//  HeaderView.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var headerDelegate: HeaderTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
    }
    
 
    
    // Profile Button
    
    
      let profileIconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile_icon"))
            iv.width(constant: 50)
            iv.height(constant: 50)
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
          return iv
      }()
    
    let userAccountName: UITextView = {
       let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Greg", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
           attributedText.append(NSAttributedString(string: "\nView Profile", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            textView.attributedText = attributedText
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.textAlignment = .left
            textView.isEditable = false
            textView.isScrollEnabled = false
            return textView
}()
    
    let profileButton: UIButton = {
        let button = UIButton()
            button.layer.masksToBounds = false
            button.setImage(#imageLiteral(resourceName: "profile_icon"), for: .normal)
            button.width(constant: 80)
            button.height(constant: 80)
            button.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
           return button
    }()
    
    // User Name Label
    
    let userName: UILabel = {
        let label = UILabel()
            label.attributedText = NSMutableAttributedString(string: "Gregory", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return label
    }()
    
    // Edit profile Button
    
    let editProfile: UIButton = {
         let button = UIButton()
             button.layer.masksToBounds = false
             button.setTitle("Edit profile", for: .normal)
             button.titleLabel?.font = UIFont(name: Fonts.gilroyMedium, size: 14)
             button.setTitleColor(Colors.fleetGreen, for:
            .normal)
        
        return button
    }()
    
    
    // Separator Line
  /*  let separator: UILabel = {
        let label = UILabel()
        label.backgroundColor = Colors.lightGreyColor
        label.width(constant: 500)
        label.height(constant: 0.4)
        return label
    }() */
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGreyColor
        view.height(constant: 0.8)
        return view
    }()
    
   /* lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileButton, userName,editProfile, separator])
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 5
        return stackView
    }() */
    
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .default
   
        addSubview(profileIconImage)
        profileIconImage.translatesAutoresizingMaskIntoConstraints = false
        profileIconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        profileIconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        
        addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: profileIconImage.bottomAnchor, constant: 20).isActive = true
        
        addSubview(userAccountName)
        userAccountName.translatesAutoresizingMaskIntoConstraints = false
        userAccountName.leadingAnchor.constraint(equalTo: profileIconImage.trailingAnchor, constant: 12).isActive = true
        userAccountName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5).isActive = true
        
        
      /*  addSubview(profileStackView)
        profileStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        profileStackView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true */
        
        
 
    }

    @objc func handleTapped() {
        headerDelegate?.didSelectHeaderCell()
       print("HANDLE TAPPED")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
