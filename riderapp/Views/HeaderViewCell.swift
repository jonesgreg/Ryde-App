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

          // Configure the view for the selected state
      }

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
  
 let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGreyColor
        view.height(constant: 0.8)
        return view
    }()
    
 
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
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileHeader: Header? {
              didSet {
                  guard let unwrappedprofileHeader = profileHeader else {return} // I want to unwrapped the properties from the location struct and avoids the ! mark
                  
                  profileIconImage.image = UIImage(named:unwrappedprofileHeader.userProfileIcon)
                let attributedText = NSMutableAttributedString(string: unwrappedprofileHeader.userName, attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                   attributedText.append(NSAttributedString(string: "\n\(unwrappedprofileHeader.viewProfile)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            userAccountName.attributedText = attributedText
                           userAccountName.textAlignment = .left
               userAccountName.backgroundColor = .clear
                           
            }
    }
    // MAY BE A PROBLEM? IF does not work
         func selectedHeader(sender: AnyObject) {
            headerDelegate?.didSelectHeaderViewCell(Selected: true, UserHeader: self)
           
       }
}
