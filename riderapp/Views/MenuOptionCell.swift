//
//  MenuOptionCell.swift
//  riderapp
//
//  Created by Gregory Jones on 9/13/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    
    // MARK: - Properties
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.gilroyMedium, size: 18)
        label.text = "Sample text"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .default
         self.clipsToBounds=true
        
       addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 14).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
