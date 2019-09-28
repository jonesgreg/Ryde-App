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
            label.attributedText = NSMutableAttributedString(string: "Gregory", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return label
    }()
    
    // Edit profile Button
    
    let editProfile: UIButton = {
         let button = UIButton()
             button.layer.masksToBounds = false
             button.setTitle("Edit profile", for: .normal)
             button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 14)
             button.setTitleColor(Colors.fleetGreen, for:
            .normal)
        
        return button
    }()
    
    
    // Separator Line
    let separator: UILabel = {
        let label = UILabel()
        label.backgroundColor = Colors.lightGreyColor
        label.width(constant: 500)
        label.height(constant: 1)
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileButton, userName,editProfile, separator])
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 5
        return stackView
    }()
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
   
        
        addSubview(profileStackView)
        profileStackView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        profileStackView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        
        
 
    }

    @objc func handleTapped() {
        headerDelegate?.didSelectHeaderCell()
       print("HANDLE TAPPED")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
